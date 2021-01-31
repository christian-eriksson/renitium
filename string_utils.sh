dequote_string() {
    string="$*"
    string=${string#\"}
    echo ${string%\"}
}

