
using PMSIDAL;
using PMSModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMSDAL
{



	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class AdvertisingDal:DYYX_BaseDal<Advertising>,IAdvertisingDal
         {


         }	

        public partial class DalFactory
        {
            public static IAdvertisingDal GetAdvertisingDal()
            {
                return new AdvertisingDal();
            }
	    }



	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class PortalTreeDataDal:DYYX_BaseDal<PortalTreeData>,IPortalTreeDataDal
         {


         }	

        public partial class DalFactory
        {
            public static IPortalTreeDataDal GetPortalTreeDataDal()
            {
                return new PortalTreeDataDal();
            }
	    }



	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class RoleInfoDal:DYYX_BaseDal<RoleInfo>,IRoleInfoDal
         {


         }	

        public partial class DalFactory
        {
            public static IRoleInfoDal GetRoleInfoDal()
            {
                return new RoleInfoDal();
            }
	    }



	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class RoleOfMenuDal:DYYX_BaseDal<RoleOfMenu>,IRoleOfMenuDal
         {


         }	

        public partial class DalFactory
        {
            public static IRoleOfMenuDal GetRoleOfMenuDal()
            {
                return new RoleOfMenuDal();
            }
	    }



	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class SchoolStyleDal:DYYX_BaseDal<SchoolStyle>,ISchoolStyleDal
         {


         }	

        public partial class DalFactory
        {
            public static ISchoolStyleDal GetSchoolStyleDal()
            {
                return new SchoolStyleDal();
            }
	    }



	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class System_LinkDal:DYYX_BaseDal<System_Link>,ISystem_LinkDal
         {


         }	

        public partial class DalFactory
        {
            public static ISystem_LinkDal GetSystem_LinkDal()
            {
                return new System_LinkDal();
            }
	    }



	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class System_NoticeDal:DYYX_BaseDal<System_Notice>,ISystem_NoticeDal
         {


         }	

        public partial class DalFactory
        {
            public static ISystem_NoticeDal GetSystem_NoticeDal()
            {
                return new System_NoticeDal();
            }
	    }



	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class System_VoteDal:DYYX_BaseDal<System_Vote>,ISystem_VoteDal
         {


         }	

        public partial class DalFactory
        {
            public static ISystem_VoteDal GetSystem_VoteDal()
            {
                return new System_VoteDal();
            }
	    }



	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class System_VoteDetailsDal:DYYX_BaseDal<System_VoteDetails>,ISystem_VoteDetailsDal
         {


         }	

        public partial class DalFactory
        {
            public static ISystem_VoteDetailsDal GetSystem_VoteDetailsDal()
            {
                return new System_VoteDetailsDal();
            }
	    }



	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class System_VoteRecordDal:DYYX_BaseDal<System_VoteRecord>,ISystem_VoteRecordDal
         {


         }	

        public partial class DalFactory
        {
            public static ISystem_VoteRecordDal GetSystem_VoteRecordDal()
            {
                return new System_VoteRecordDal();
            }
	    }



	     /// </summary>
	     ///	
	     /// </summary>
		 public partial class UserInfoDal:DYYX_BaseDal<UserInfo>,IUserInfoDal
         {


         }	

        public partial class DalFactory
        {
            public static IUserInfoDal GetUserInfoDal()
            {
                return new UserInfoDal();
            }
	    }
}