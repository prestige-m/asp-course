using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;

namespace Callboard
{
    public class Alert
    {
        private StringBuilder messages = new StringBuilder("<div class=\"alert alert-success\" role=\"alert\"><ul>");
        private StringBuilder errors = new StringBuilder("<div class=\"alert alert-danger\" role=\"alert\"><ul>");

        public int errorCounter { protected set; get; }
        public int messageCounter { protected set; get; }
        public string getErrors()
        {
            if (errorCounter > 0)
            {
                errors.Append("</ul></div>");
                return errors.ToString();
            }
            return "";
        }
        public string getMessages()
        {
            if (messageCounter > 0)
            {
                messages.Append("</ul></div>");
                return messages.ToString();
            }
            return "";
        }

        public void AddMessageAlert(string text)
        {
            messages.Append($"<li>{text}</li>");
            messageCounter++;
        }

        public void AddErrorAlert(string text)
        {
            errors.Append($"<li>{text}</li>");
            errorCounter++;
        }

        public string GetAlerts()
        {
            string result = this.getErrors() + this.getMessages();
            messages = new StringBuilder();
            errors = new StringBuilder();
            errorCounter = messageCounter = 0;
            return result;
        }
    }
}