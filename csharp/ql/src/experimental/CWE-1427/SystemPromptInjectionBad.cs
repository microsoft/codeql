using System.Web.Mvc;
using OpenAI.Chat;

public class BadController : Controller
{
    [HttpPost]
    public ActionResult Configure(string persona)
    {
        // BAD: untrusted input is used as the system prompt.
        var system = new SystemChatMessage(persona);
        return View();
    }
}
