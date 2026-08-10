package example

import (
	"net/http"

	"github.com/tmc/langchaingo/llms"
)

func handlerBad(w http.ResponseWriter, r *http.Request) {
	persona := r.URL.Query().Get("persona")

	// BAD: untrusted input from the request is used as the system prompt,
	// allowing an attacker to override the model's instructions.
	messages := []llms.ChatMessage{
		llms.SystemChatMessage{Content: persona},
		llms.HumanChatMessage{Content: "Hello!"},
	}

	_ = messages
}
