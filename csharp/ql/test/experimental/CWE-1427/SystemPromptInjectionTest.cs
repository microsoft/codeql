using System.Web.Mvc;
using OpenAI.Chat;

namespace SystemPromptInjectionTest.Controllers
{
    public class PromptController : Controller
    {
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Bad(string persona) // $ Source=r1
        {
            var m1 = new SystemChatMessage(persona); // $ Alert=r1
            var m2 = ChatMessage.CreateSystemMessage(persona); // $ Alert=r1
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Good(string persona)
        {
            // System prompt is a fixed trusted string; user input belongs in a user message.
            var system = new SystemChatMessage("You are a helpful assistant.");
            var user = new UserChatMessage(persona);
            return View();
        }
    }
}
