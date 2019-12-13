using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Callboard
{
    public static class Alert
    {
        public static string getErrorAlert(string errorMessage)
        {
            return $"<div class=\"alert alert-danger\" role=\"alert\">{errorMessage}</div>";
        }
        public static string getMessageAlert(string message)
        {
            return $"<div class=\"alert alert-success\" role=\"alert\">{message}</div>";
        }
    }
}