  
using System;
namespace PMSModel
{
    

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class Advertising
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Description { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? MenuId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string CreativeHTML { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public long? ClickNum { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ImageUrl { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ModelType { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string FileName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string FilePath { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public long? SortId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? isPush { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class PortalTreeData
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? Display { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? PId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string BeforeUrl { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? BeforeAfter { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string AfterUrl { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? SortId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string EnName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? DisplayCount { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string DisplayType { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? MenuLevelIndex { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? IsShowIndex { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ShowIndexSort { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class RoleInfo
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string RoleName { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class RoleOfMenu
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? RoleId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? MenuId { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class SchoolStyle
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Title { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ImageUrl { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? MenuId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Description { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? SortId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string FileName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string FilePath { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public long? ClickNum { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ModelType { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class System_Link
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ImageUrl { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? SortId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Title { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Href { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? LinkType { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? OneNavId { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class System_Notice
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Title { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Contents { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Hot { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? SortId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? ClickNum { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Creator { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string ShowImgUrl { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string FilePath { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string FileName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? isPush { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? MenuId { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class System_Vote
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Title { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Description { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? isPush { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public long? SortId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class System_VoteDetails
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string Title { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? VoteId { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class System_VoteRecord
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? DetailsId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string IP { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? Count { get; set; }
    }

	/// </summary>
	///	
	/// </summary>
	[Serializable]
    public partial class UserInfo
    {

		/// <summary>
		/// 
		/// </summary>
		public int? Id { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string LoginName { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public string LoginPassword { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public int? RoleId { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public Byte? IsDelete { get; set; }
		/// <summary>
		/// 
		/// </summary>
		public DateTime? CreateTime { get; set; }
    }
}
