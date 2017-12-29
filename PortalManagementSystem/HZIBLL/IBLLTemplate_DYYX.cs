
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMSModel;


namespace PMSIBLL
{

	/// </summary>
	///	
	/// </summary>
    public interface IAdvertisingService:IBaseService_DYYX<Advertising>
    {

    }
	

	/// </summary>
	///	
	/// </summary>
    public interface IPortalTreeDataService:IBaseService_DYYX<PortalTreeData>
    {

    }
	

	/// </summary>
	///	
	/// </summary>
    public interface IRoleInfoService:IBaseService_DYYX<RoleInfo>
    {

    }
	

	/// </summary>
	///	
	/// </summary>
    public interface IRoleOfMenuService:IBaseService_DYYX<RoleOfMenu>
    {

    }
	

	/// </summary>
	///	
	/// </summary>
    public interface ISchoolStyleService:IBaseService_DYYX<SchoolStyle>
    {

    }
	

	/// </summary>
	///	
	/// </summary>
    public interface ISystem_LinkService:IBaseService_DYYX<System_Link>
    {

    }
	

	/// </summary>
	///	
	/// </summary>
    public interface ISystem_NoticeService:IBaseService_DYYX<System_Notice>
    {

    }
	

	/// </summary>
	///	
	/// </summary>
    public interface ISystem_VoteService:IBaseService_DYYX<System_Vote>
    {

    }
	

	/// </summary>
	///	
	/// </summary>
    public interface ISystem_VoteDetailsService:IBaseService_DYYX<System_VoteDetails>
    {

    }
	

	/// </summary>
	///	
	/// </summary>
    public interface ISystem_VoteRecordService:IBaseService_DYYX<System_VoteRecord>
    {

    }
	

	/// </summary>
	///	
	/// </summary>
    public interface IUserInfoService:IBaseService_DYYX<UserInfo>
    {

    }
	
}