import javax.servlet.http.HttpServletRequest;
import dev.langchain4j.data.message.SystemMessage;

public class SystemPromptInjectionBad {
  private HttpServletRequest request;

  public SystemMessage build() {
    String userInput = request.getParameter("persona");
    // BAD: untrusted input is used as the system prompt.
    return SystemMessage.from(userInput);
  }
}
