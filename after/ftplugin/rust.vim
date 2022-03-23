let g:ale_rust_cargo_check_all_targets = 1
let g:ale_rust_cargo_check_tests = 1
let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')
let g:ale_rust_cargo_clippy_options = '--all-targets --all-features -- -D warnings'
let g:ale_rust_rls_config = {
            \   'rust': {
            \     'clippy_preference': 'on'
            \   }
            \ }
