using System.Web.Mvc;
using OpenAI.Chat;

public class GoodController : Controller
{
    [HttpPost]
    public ActionResult Configure(string persona)
    {
        // GOOD: the system prompt is trusted, and untrusted input is confined to a user message.
        var system = new SystemChatMessage("You are a helpful assistant.");
        var user = new UserChatMessage(persona);
        return View();
    }
}
