herdr_bin="$HERDR_BIN_PATH"

retain_review() {
    printf '\nCould not confirm review delivery. Export retained at: %s\n' "$output" >&2
    if [[ -t 0 ]]; then
        printf 'Press Enter to close this tab.' >&2
        read -r _ || true
    fi
    exit 1
}

if [[ -n "${TUICR_ORIGIN_PANE:-}" ]]; then
    umask 077
    output=$(mktemp "${TMPDIR:-/tmp}/tuicr-review.XXXXXX")

    if ! tuicr --stdout > "$output"; then
        retain_review
    fi

    review=$(cat "$output")
    if [[ -n "${review//[[:space:]]/}" ]]; then
        if ! "$herdr_bin" agent prompt "$TUICR_ORIGIN_PANE" "$review"; then
            retain_review
        fi
    fi

    rm -f "$output"
    exit 0
fi

origin_pane="$HERDR_ACTIVE_PANE_ID"

"$herdr_bin" agent get "$origin_pane" >/dev/null

result=$("$herdr_bin" tab create \
    --workspace "$HERDR_ACTIVE_WORKSPACE_ID" \
    --cwd "$HERDR_ACTIVE_PANE_CWD" \
    --label Review \
    --env "TUICR_ORIGIN_PANE=$origin_pane" \
    --focus)
pane_id=$(printf '%s' "$result" | jq -er '.result.root_pane.pane_id')
"$herdr_bin" pane run "$pane_id" "exec '$0'"
