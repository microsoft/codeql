package main

import (
	"net/http"

	"github.com/tmc/langchaingo/llms"
)

func handler(w http.ResponseWriter, r *http.Request) {
	persona := r.URL.Query().Get("persona")

	// BAD: untrusted input is used as the system prompt.
	_ = llms.SystemChatMessage{Content: persona}

	// GOOD: fixed, trusted system prompt; untrusted input confined to a human message.
	_ = llms.SystemChatMessage{Content: "You are a helpful assistant."}
	_ = llms.HumanChatMessage{Content: persona}
}

func main() {
	http.HandleFunc("/", handler)
}
