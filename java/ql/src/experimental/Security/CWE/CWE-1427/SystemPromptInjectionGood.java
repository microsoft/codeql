import javax.servlet.http.HttpServletRequest;
import dev.langchain4j.data.message.SystemMessage;
import dev.langchain4j.data.message.UserMessage;

public class SystemPromptInjectionGood {
  private HttpServletRequest request;

  public void build() {
    String userInput = request.getParameter("persona");
    // GOOD: the system prompt is trusted, and untrusted input is confined to a user message.
    SystemMessage system = SystemMessage.from("You are a helpful assistant.");
    UserMessage user = UserMessage.from(userInput);
  }
}
