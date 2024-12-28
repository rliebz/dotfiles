import glob
import os

import dotbot


class Uninstall(dotbot.Plugin):
    """
    Removes all symlinks defined in the link directive.
    """

    def can_handle(self, directive):
        return directive == "link"

    def handle(self, directive, data):
        success = True
        for path, config in data.items():
            success &= self._uninstall(path, config)
        if success:
            self._log.info("All targets have been uninstalled")
        else:
            self._log.error("Some targets were not successfully uninstalled")
        return success

    def _uninstall(self, target, config):
        target = os.path.expanduser(target)
        if isinstance(config, dict) and config.get("glob", False):
            return self._uninstall_glob(target, config)

        if not os.path.islink(target):
            self._log.debug(f"Ignoring non-link file {target}")
            return True

        match config:
            case {"path": source}:
                pass
            case str(source):
                pass
            case _:
                source = os.path.basename(target).removeprefix(".")

        points_at = os.path.join(os.path.dirname(target), os.readlink(target))
        if os.path.realpath(points_at) != os.path.realpath(source):
            self._log.debug(f"Link {target} -> {points_at} not removed")
            return True

        self._log.lowinfo(f"Removing link {target} -> {source}")
        try:
            os.remove(target)
        except Exception as e:
            self._log.error(f"Failed to remove {target}: {e}")
            return False
        return True

    def _uninstall_glob(self, dir, config):
        success = True
        path = config.get("path", dir)
        for source in glob.glob(path, recursive=True):
            glob_dirname = os.path.dirname(os.path.commonprefix([path, source]))
            glob_item = source.removeprefix(glob_dirname + os.sep)
            success &= self._uninstall(os.path.join(dir, glob_item), source)
        return success

    @staticmethod
    def _in_directory(path, directory):
        """
        Returns true if the path is in the directory.
        """
        directory = os.path.join(os.path.realpath(directory), "")
        path = os.path.realpath(path)
        return os.path.commonprefix([path, directory]) == directory
