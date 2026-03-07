{ pkgs, ... }:

let
  codexWrapper = pkgs.writeShellApplication {
    name = "codex";
    text = ''
      set -euo pipefail

      if [ -n "''${CODEX_REAL_BIN:-}" ] && [ -x "''${CODEX_REAL_BIN}" ]; then
        exec "''${CODEX_REAL_BIN}" "$@"
      fi

      case "$(uname -s)-$(uname -m)" in
        Linux-x86_64) platform_dir="linux-x86_64" ;;
        Linux-aarch64) platform_dir="linux-arm64" ;;
        Darwin-arm64) platform_dir="darwin-arm64" ;;
        Darwin-x86_64) platform_dir="darwin-x86_64" ;;
        *)
          echo "Unsupported platform for Codex wrapper: $(uname -s)-$(uname -m)" >&2
          exit 1
          ;;
      esac

      shopt -s nullglob

      candidates=(
        "$HOME/.vscode/extensions/openai.chatgpt-"*/bin/"$platform_dir"/codex
        "$HOME/.vscode-oss/extensions/openai.chatgpt-"*/bin/"$platform_dir"/codex
        "$HOME/.vscode-server/extensions/openai.chatgpt-"*/bin/"$platform_dir"/codex
        "$HOME/.cursor/extensions/openai.chatgpt-"*/bin/"$platform_dir"/codex
      )

      for candidate in "''${candidates[@]}"; do
        if [ -x "$candidate" ]; then
          exec "$candidate" "$@"
        fi
      done

      cat >&2 <<'EOF'
      Codex CLI not found.

      This wrapper looks for the OpenAI ChatGPT/Codex editor extension binary in:
      - ~/.vscode/extensions
      - ~/.vscode-oss/extensions
      - ~/.vscode-server/extensions
      - ~/.cursor/extensions

      You can also point it explicitly at the real binary:
        export CODEX_REAL_BIN="$HOME/path/to/codex"

      Then retry `codex`.
      EOF

      exit 1
    '';
  };
in
{
  home.packages = [
    codexWrapper
  ];
}
