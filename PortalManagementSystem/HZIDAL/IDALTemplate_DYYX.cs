
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMSUtility;
using PMSModel;
using System.Configuration;


namespace PMSIDAL
{

	/// </summary>
	///	
	/// </summary>
    public interface IAdvertisingDal: IBaseDal_DYYX<Advertising>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IPortalTreeDataDal: IBaseDal_DYYX<PortalTreeData>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IRoleInfoDal: IBaseDal_DYYX<RoleInfo>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IRoleOfMenuDal: IBaseDal_DYYX<RoleOfMenu>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ISchoolStyleDal: IBaseDal_DYYX<SchoolStyle>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ISystem_LinkDal: IBaseDal_DYYX<System_Link>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ISystem_NoticeDal: IBaseDal_DYYX<System_Notice>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ISystem_VoteDal: IBaseDal_DYYX<System_Vote>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ISystem_VoteDetailsDal: IBaseDal_DYYX<System_VoteDetails>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface ISystem_VoteRecordDal: IBaseDal_DYYX<System_VoteRecord>
    {


		
    }

	/// </summary>
	///	
	/// </summary>
    public interface IUserInfoDal: IBaseDal_DYYX<UserInfo>
    {


		
    }
}