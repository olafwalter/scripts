# send text in a Teams-safe way
b64() {
    echo "Enter your message, finished by CTRL-D"
    message=$(cat)
    echo "Teams-safe message:"
    echo "echo $(echo $message | base64) | base64 -d "
}
