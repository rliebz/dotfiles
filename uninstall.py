import os, dotbot

class Uninstall(dotbot.Plugin):
    '''
    Removes all symlinks which point to the dotfiles directory.
    '''

    _directive = 'uninstall'

    def can_handle(self, directive):
        return directive == self._directive

    def handle(self, directive, data):
        if directive != self._directive:
            raise ValueError('Uninstall cannot handle directive %s' % directive)
        return self._process_uninstall(data)

    def _process_uninstall(self, targets):
        success = True
        print('Starting the process')
        for target in targets:
            success &= self._uninstall(target)
        if success:
            self._log.info('All targets have been uninstalled')
        else:
            self._log.error('Some targets were not successfully uninstalled')
        return success

    def _uninstall(self, target):
        '''
        Removes all symbolic links in target if they point to a subdirectory of
        the base directory.
        '''
        if not os.path.isdir(os.path.expanduser(target)):
            self._log.debug('Ignoring nonexistent directory %s' % target)
            return True
        for item in os.listdir(os.path.expanduser(target)):
            path = os.path.join(os.path.expanduser(target), item)
            if os.path.islink(path):
                points_at = os.path.join(os.path.dirname(path), os.readlink(path))
                if self._in_directory(path, self._context.base_directory()):
                    self._log.lowinfo('Removing link %s -> %s' % (path, points_at))
                    os.remove(path)
                else:
                    self._log.lowinfo('Link %s -> %s not removed.' % (path, points_at))
        return True

    def _in_directory(self, path, directory):
        '''
        Returns true if the path is in the directory.
        '''
        directory = os.path.join(os.path.realpath(directory), '')
        path = os.path.realpath(path)
        return os.path.commonprefix([path, directory]) == directory
