// Code generated for testing. This is a simple stub of
// github.com/tmc/langchaingo/llms, strictly for use in testing.
package llms

type ChatMessage interface {
	GetType() string
	GetContent() string
}

type SystemChatMessage struct {
	Content string
}

func (m SystemChatMessage) GetType() string { return "system" }

func (m SystemChatMessage) GetContent() string { return m.Content }

type HumanChatMessage struct {
	Content string
}

func (m HumanChatMessage) GetType() string { return "human" }

func (m HumanChatMessage) GetContent() string { return m.Content }
