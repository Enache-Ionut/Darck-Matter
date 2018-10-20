using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SpotThatFireWebApp.Logic
{
    public class ActionExecute
    {
        #region Public Methods

        public static void BeginInvoke(Action aAction)
        {
            aAction.BeginInvoke(aAction.EndInvoke, null);
        }
        public static void Invoke(Action aAction)
        {
            aAction.Invoke();
        }

        #endregion

    }
}