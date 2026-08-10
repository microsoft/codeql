package example

import (
	"net/http"

	"github.com/tmc/langchaingo/llms"
)

func handlerGood(w http.ResponseWriter, r *http.Request) {
	persona := r.URL.Query().Get("persona")

	// GOOD: the system prompt is a fixed, trusted string, and the untrusted
	// input is confined to a human message where it is treated as data.
	messages := []llms.ChatMessage{
		llms.SystemChatMessage{Content: "You are a helpful assistant."},
		llms.HumanChatMessage{Content: persona},
	}

	_ = messages
}
