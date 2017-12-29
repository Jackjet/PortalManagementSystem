
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMSUtility;
using PMSDAL;
using PMSModel;
using PMSIBLL;



namespace PMSBLL
{

	/// </summary>
	///	
	/// </summary>
    public partial class AdvertisingService:BaseService_DYYX<Advertising>,IAdvertisingService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetAdvertisingDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class PortalTreeDataService:BaseService_DYYX<PortalTreeData>,IPortalTreeDataService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetPortalTreeDataDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class RoleInfoService:BaseService_DYYX<RoleInfo>,IRoleInfoService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetRoleInfoDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class RoleOfMenuService:BaseService_DYYX<RoleOfMenu>,IRoleOfMenuService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetRoleOfMenuDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class SchoolStyleService:BaseService_DYYX<SchoolStyle>,ISchoolStyleService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetSchoolStyleDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class System_LinkService:BaseService_DYYX<System_Link>,ISystem_LinkService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetSystem_LinkDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class System_NoticeService:BaseService_DYYX<System_Notice>,ISystem_NoticeService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetSystem_NoticeDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class System_VoteService:BaseService_DYYX<System_Vote>,ISystem_VoteService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetSystem_VoteDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class System_VoteDetailsService:BaseService_DYYX<System_VoteDetails>,ISystem_VoteDetailsService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetSystem_VoteDetailsDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class System_VoteRecordService:BaseService_DYYX<System_VoteRecord>,ISystem_VoteRecordService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetSystem_VoteRecordDal();
        }
		

    }
	

	/// </summary>
	///	
	/// </summary>
    public partial class UserInfoService:BaseService_DYYX<UserInfo>,IUserInfoService

    {
	 public override void SetCurrentDal()
        {
            CurrentDal = DalFactory.GetUserInfoDal();
        }
		

    }
	
}