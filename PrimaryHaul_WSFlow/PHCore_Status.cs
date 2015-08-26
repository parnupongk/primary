using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PrimaryHaul_WSFlow
{
    
    public class PHCore_Status
    {
        public enum RoleID
        {
            A1,
            A2,
            HL,
            VD,
        }
        public enum SignInStatus
        {
            //
            // Summary:
            //     Sign in was successful
            Success,
            //
            // Summary:
            //     User is locked out
            LockedOut,
            //
            // Summary:
            //     Sign in requires addition verification (i.e. two factor)
            RequiresVerification,
            //
            // Summary:
            //     Sign in failed
            Failure,
            PasswordExpired
        }

        private SignInStatus status;
        public SignInStatus Status
        {
            get { return status; }
            set { status = value; }
        }

        private string message;
        public string Message
        {
            get { return message; }
            set { message = value; }
        }

        private RoleID roleId;
        public RoleID RoleId
        {
            get { return roleId; }
            set { roleId = value; }
        }

        private string userName;
        public string UserName
        {
            get { return userName; }
            set { userName = value; }
        }

        private string strUserId;
        public string UserId
        {
            get { return strUserId; }
            set { strUserId = value; }
        }
    }
}
