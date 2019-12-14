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
        private int errorCounter = 0;
        private int messageCounter = 0;
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
            return this.getErrors() + this.getMessages();
        }
    }
}