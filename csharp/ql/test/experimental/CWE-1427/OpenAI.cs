namespace OpenAI.Chat
{
    // Minimal stub of the OpenAI .NET SDK chat message types for testing.
    public class ChatMessage
    {
        public static SystemChatMessage CreateSystemMessage(string content)
        {
            return null;
        }
    }

    public class SystemChatMessage : ChatMessage
    {
        public SystemChatMessage(string content) { }
    }

    public class UserChatMessage : ChatMessage
    {
        public UserChatMessage(string content) { }
    }
}
