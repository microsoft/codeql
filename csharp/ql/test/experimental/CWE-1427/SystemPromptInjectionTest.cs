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

        [HttpPost]
        public ActionResult GoodRoleAdapters(string persona) // $ Source=r2
        {
            ConvertSwitchWithTrustedRole("user", persona);
            ConvertIfWithTrustedRole("user", persona);
            return View();
        }

        [HttpPost]
        public ActionResult BadRoleAdapters(string role, string content) // $ Source=r3 Source=r4
        {
            ConvertSwitchWithUntrustedRole(role, content);
            ConvertIfWithUntrustedRole(role, content);
            return View();
        }

        private static ChatMessage ConvertSwitchWithTrustedRole(string role, string content)
        {
            return role switch
            {
                "system" => new SystemChatMessage(content),
                _ => new UserChatMessage(content),
            };
        }

        private static ChatMessage ConvertIfWithTrustedRole(string role, string content)
        {
            if (role.Equals("system"))
            {
                return ChatMessage.CreateSystemMessage(content);
            }

            return new UserChatMessage(content);
        }

        private static ChatMessage ConvertSwitchWithUntrustedRole(string role, string content)
        {
            return role switch
            {
                "system" => new SystemChatMessage(content), // $ Alert=r4
                _ => new UserChatMessage(content),
            };
        }

        private static ChatMessage ConvertIfWithUntrustedRole(string role, string content)
        {
            if (role.Equals("system"))
            {
                return ChatMessage.CreateSystemMessage(content); // $ Alert=r4
            }

            return new UserChatMessage(content);
        }
    }
}
