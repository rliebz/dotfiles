# Rust should be installed using rustup and not Homebrew
# Run the following to download source code for use with auto-completion:
#     `rustup component add rust-src`
export PATH=${PATH}:${HOME}/.cargo/bin

# Use wildcard path to be system agnostic
rust_src_array=(${HOME}/.multirust/toolchains/*/lib/rustlib/src/rust/src) &> /dev/null
for rust_src_dir in $rust_src_array; do
    if test -d "$rust_src_dir"; then
        export RUST_SRC_PATH=$rust_src_dir
    fi

    unset rust_src_dir
    break
done
unset rust_src_array
