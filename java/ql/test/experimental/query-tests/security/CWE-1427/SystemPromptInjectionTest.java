import javax.servlet.http.HttpServletRequest;
import dev.langchain4j.data.message.SystemMessage;

public class SystemPromptInjectionTest {

  private HttpServletRequest request;

  public void bad() {
    String tainted = request.getParameter("p");
    SystemMessage.from(tainted); // BAD: system prompt injection
    SystemMessage.systemMessage(tainted); // BAD: system prompt injection
    SystemMessage m = new SystemMessage(tainted); // BAD: system prompt injection
  }

  public void good() {
    String tainted = request.getParameter("p");
    // System prompt is a fixed trusted string; user input belongs in a user message.
    SystemMessage.from("You are a helpful assistant.");
    UserMessage.from(tainted);
  }
}

class UserMessage {
  static UserMessage from(String text) {
    return new UserMessage();
  }
}
