USE [master]
GO
/****** Object:  Database [MotelRoomManagement]    Script Date: 9/24/2019 1:07:00 PM ******/
CREATE DATABASE [MotelRoomManagement]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MotelRoomManagement', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\MotelRoomManagement.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'MotelRoomManagement_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\MotelRoomManagement_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [MotelRoomManagement] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MotelRoomManagement].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MotelRoomManagement] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MotelRoomManagement] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MotelRoomManagement] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MotelRoomManagement] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MotelRoomManagement] SET ARITHABORT OFF 
GO
ALTER DATABASE [MotelRoomManagement] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MotelRoomManagement] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MotelRoomManagement] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MotelRoomManagement] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MotelRoomManagement] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MotelRoomManagement] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MotelRoomManagement] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MotelRoomManagement] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MotelRoomManagement] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MotelRoomManagement] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MotelRoomManagement] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MotelRoomManagement] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MotelRoomManagement] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MotelRoomManagement] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MotelRoomManagement] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MotelRoomManagement] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MotelRoomManagement] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MotelRoomManagement] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [MotelRoomManagement] SET  MULTI_USER 
GO
ALTER DATABASE [MotelRoomManagement] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MotelRoomManagement] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MotelRoomManagement] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MotelRoomManagement] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [MotelRoomManagement] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'MotelRoomManagement', N'ON'
GO
ALTER DATABASE [MotelRoomManagement] SET QUERY_STORE = OFF
GO
USE [MotelRoomManagement]
GO
/****** Object:  Table [dbo].[tbl_MotelRoom]    Script Date: 9/24/2019 1:07:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_MotelRoom](
	[ID] [varchar](10) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](200) NOT NULL,
	[Information] [nvarchar](max) NULL,
	[Longitude] [varchar](max) NOT NULL,
	[Latitude] [varchar](max) NOT NULL,
 CONSTRAINT [PK_tbl_MotelRoom] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_RoomImages]    Script Date: 9/24/2019 1:07:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_RoomImages](
	[RoomID] [nchar](10) NULL,
	[Path] [varchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Rooms]    Script Date: 9/24/2019 1:07:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Rooms](
	[RoomID] [nchar](10) NOT NULL,
	[Status] [bit] NOT NULL,
	[Price] [nchar](10) NOT NULL,
	[MotelRoomID] [varchar](10) NOT NULL,
 CONSTRAINT [PK_tbl_Rooms] PRIMARY KEY CLUSTERED 
(
	[RoomID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_User]    Script Date: 9/24/2019 1:07:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_User](
	[UserID] [nvarchar](50) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[PhoneNumber] [varchar](12) NULL,
	[Email] [nvarchar](max) NULL,
	[IDCardNumber] [nvarchar](50) NULL,
	[Address] [nvarchar](100) NULL,
	[Password] [nvarchar](15) NULL,
	[Type] [int] NULL,
 CONSTRAINT [PK_tbl_Owner] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[tbl_MotelRoom] ([ID], [Name], [UserID], [Address], [Information], [Longitude], [Latitude]) VALUES (N'H001', N'PHÒNG SẠCH SẼ THOÁNG MÁT BAN CÔNG GIỜ GIẤC TỰ DO GẦN D1 D2 , ĐH HUTECH', N'phu123', N'281/3 Ung Van Khiêm, Phu?ng 25, Qu?n Bình Th?nh.', N'Phòng tiện nghi có bếp riêng ngay gần toà nhà Pearl Plaza, gần Nguyễn Văn Thương, nên rất sầm uất, tìm gì cũng có. Gần chợ, siêu thị.

Nhà nằm trên đường Ung Văn Khiêm nên dễ di chuyển ra Điện Biên Phủ đi đâu cũng thuận tiện.

- Phòng rộng 18 - 25m2, sạch sẽ, được trang bị tiện nghi:

+ Máy lạnh.

+ Máy giặt.

+ WC riêng.

Đặc biệt phòng nào cũng có kệ bếp nấu ăn riêng. Lại view sông nên gió lúc nào cũng lùa qua thoáng mát.

. Có thang máy, máy giặt miễn phí.

Giờ giấc thoải mái tự do.

+ Chỗ để xe rộng, bảo vệ 24/24.

+ Dọn vệ sinh hàng tuần.

Giá thuê : 4.0- 4.3 triệu/tháng.

Địa chỉ: 281/3 Ung Văn Khiêm, Phường 25, Quận Bình Thạnh.', N'106.7230611', N'10.8020228')
INSERT [dbo].[tbl_MotelRoom] ([ID], [Name], [UserID], [Address], [Information], [Longitude], [Latitude]) VALUES (N'H002', N'Phòng có BAN CÔNG, gần ĐH Hutech - Hàng Xanh, 69/28 D2, Bình Thạnh', N'phu123', N'69/28 Đường D2, P.25, Bình Thạnh ', N'Hệ thống BĐS cho thuê Khai Minh. 
Chi nhánh Bình Thạnh, TP. HCM. 

ĐỊA CHỈ : 69/28 Đường D2, P.25, Bình Thạnh 
-	Gần ĐH Hutech, ĐH Hồng Bàng, ĐH Ngoại Thương, 
-	Gần Hàng Xanh sầm uất, Pear Plaza, 
-	Qua Q1 10 phút 
-	Gần khu đô thị Vinhome centrak Park ( Landmard 81) 

GIÁ : 5.2 Triệu / tháng 
DT : 40m2 
-	Có ban công, wc riêng, cửa sổ 

TIỆN ÍCH CHUNG : 
- Giờ giấc tự do, có chìa khóa riêng. 
- Truyền hình cáp, wifi cáp quang. 
- Có bảo vệ 24/24 
- Khu an ninh, có lắp đặt hệ thống camera quan sát xe. 
- Cho nấu ăn thoải mái trong phòng. 
- Điện: 3.500 đ/kwh. 
- Nước: 100.000 đ/tháng (nước máy). 
-Được quản lý, vận hành chuyên nghiệp bởi hệ thống KHAI MINH với hơn 1.200 phòng trên khắp các QUẬN tại TP.HCM 

Liên hệ : 0917460309 (zalo) - 0972776327', N'106.7156228', N'10.8032236')
INSERT [dbo].[tbl_MotelRoom] ([ID], [Name], [UserID], [Address], [Information], [Longitude], [Latitude]) VALUES (N'H003', N'Phòng 50m2, có BAN CÔNG, MÁY LẠNH, gần ĐH Hutech - Hàng Xanh', N'phu123', N'441/79 Điện Biên Phủ, P. 25, Q. Bình Thạnh.', N'- Cách cổng trước Hutech 100m, có thể đi bộ qua ĐH GTVT, ĐH Ngoại Thương.
- Ngay khu Hàng Xanh sầm uất, đầy đủ các tiện ích.
- Hẻm xe hơi rất lớn, thông ra nhiều tuyến đường D2, D3, D5, XVNT, Đinh Bộ Lĩnh...

GIÁ: 5.2 tr/th - DT: 50m2.
- Có máy lạnh, ban công.
- WC riêng biệt

TIỆN ÍCH CHUNG:
- Giờ giấc tự do, có chìa khóa riêng.
- Truyền hình cáp, wifi cáp quang.
- Đậu xe trong nhà miễn phí.
- Khu an ninh, có lắp đặt hệ thống camera quan sát xe.
(Bạn có thể trực tiếp quan sát camera qua điện thoại, máy tính của mình).
- Cho nấu ăn thoải mái trong phòng.
- Điện: 3.500/kw.
- Nước: 100.000/người/tháng (nước máy).
- Được quản lý, vận hành chuyên nghiệp bởi hệ thống KHAI MINH với hơn 1.200 phòng trên khắp các QUẬN tại TP.HCM 

Liên hệ : 0917460309 (zalo) - 0972776327', N'106.71794499999999', N'10.798288')
INSERT [dbo].[tbl_MotelRoom] ([ID], [Name], [UserID], [Address], [Information], [Longitude], [Latitude]) VALUES (N'H004', N'Phòng MỚI 100%,có BAN CÔNG, gần Pear Plaza - Hàng Xanh, Bình Thạnh', N'phu123', N'4A/95 Nguyễn Văn Thương (D1), P.25, Bình Thạnh', N'+ Nhà mới 100%, thiết bị cao cấp.
+ Đường hẻm rộng rải.
+ Phòng sạch sẽ, thoáng mát.
+ Có wc riêng, máy nước nóng, sân thượng, ban công.

- Vị trí, giao thông thuận tiện.
+ Gần Hàng xanh Sầm Uất, dễ dàng di chuyển đến các quận khác.
+ Gần Landmark 81 địa điểm HOT của SÀI THÀNH.
+ Gần Pearl Plaza sang chảnh.

- GIÁ: 3.8 - 5 triệu/tháng .
- DT: 24 - 30m2

TIỆN ÍCH CHUNG :
- Giờ giấc tự do, có chìa khóa riêng.
- Truyền hình cáp, wifi cáp quang.
- Khu dân cư cao cấp, an ninh, gần trụ sở bảo vệ dân phố.
- Cho nấu ăn thoải mái trong phòng.
- Điện: 3.500 đ/kwh.
- Nước: 100.000 đ/người/tháng (nước máy)
- Được quản lý, vận hành chuyên nghiệp bởi hệ thống KHAI MINH với hơn 1.200 phòng trên khắp các QUẬN tại TP.HCM 

Liên hệ : 0917460309 (zalo) - 0972776327', N'106.71979799999997', N'10.803091')
INSERT [dbo].[tbl_MotelRoom] ([ID], [Name], [UserID], [Address], [Information], [Longitude], [Latitude]) VALUES (N'H005', N'Siêu phẩm kí túc xá Đ.Ung Văn Khiêm, Bình Thạnh, đẳng cấp, sang trọng sát ĐH Ngoại Thương', N'phu123', N'48/10 Đường Ung Văn Khiêm, Phường 25, Quận Bình Thạnh, Hồ Chí Minh', N'Bạn là sinh viên ĐH Hutech, ĐH Hồng Bàng, ĐH Giao thông Vận Tải, ĐH Ngoại Thương, UEF… đang tìm kiếm phòng KTX với các tiện nghi như.

-  Nội thất ĐẦY ĐỦ, tiện nghi.

-  Giờ giấc TỰ DO, không ở chung với chủ ( tha hồ kiếm việc làm thêm, cải thiện thu nhập mà không sợ chủ nhà khóa cửa ).

-  MIỄN PHÍ wifi…

-  Bãi đậu xe rộng rãi.

-  Nhà đẹp, thoát mát.

-  Hàng xóm xinh đẹp và thân thiện.

-  Khu tự học rộng rãi, thoát mát.

-  Văn hóa ký túc xá văn minh và lịch sự giúp bạn thoải mái nghỉ ngơi sau những giờ học tập mệt mỏi.

- An ninh ký túc xá luôn được đảm bảo vì có hệ thống camera và bảo vệ 24/24.

-  Quản lý xử lý sự cố nhiệt tình và nhanh chóng.

Địa chỉ: 48/10 Ung Văn Khiêm, Phường 25, Quận Bình Thạnh

Diện tích: 30m2

ĐẶC BIỆT: Chỉ với 1,5 tr/tháng/Gường ( phòng như ảnh )

Phòng có 6 gường duy nhất dành cho Nữ

Điện: 3,5k/số.

Nước 20k/m3.

Điện nước Nguyên phòng 6 gường dùng chung Chia ra.

xe 120k/người.

 Bạn Hãy nhanh tay liên hệ Mr Khánh để được lên lịch hẹn giờ đến xem phòng và tư vấn kĩ hơn.', N'106.71880609999994', N'10.8070065')
INSERT [dbo].[tbl_MotelRoom] ([ID], [Name], [UserID], [Address], [Information], [Longitude], [Latitude]) VALUES (N'H006', N'Phòng trọ Bình Thạnh gần hàng xanh 25m2', N'phu123', N'Đường D2, Phường 25, Quận Bình Thạnh, Hồ Chí Minh', N'Phòng trọ quận bình thạnh gần hàng xanh
- Giá thuê: 4,5tr/tháng khép kín (cọc 1 tháng)
- Có máy lạnh, cửa sổ rèm
- Chỗ để xe rộng rãi (không thu phí)
- Khu vực an ninh trật tự
- Giờ giấc tự do thoải mái, không chung chủ
- Gần các trường đại học: Hutech, Giao thông vận tải, ngoại thương, Hồng Bàng,.....
- Gần hàng xanh 700m, Bến xe buýt, Landmark81
- Xung quanh là các cửa hàng tiện ích, chợ, bệnh viện, siêu thị
Liên hệ xem phòng 0947640083', N'106.71597139999994', N'10.8058277')
INSERT [dbo].[tbl_MotelRoom] ([ID], [Name], [UserID], [Address], [Information], [Longitude], [Latitude]) VALUES (N'H007', N'Cho Thuê Phòng Trọ Chưa Bóc Tem Ngay Xô Viết Nghệ Tĩnh , Bình Thạnh , Đầy Đủ Tiện Nghi', N'phu123', N'818/19 Đường Xô Viết Nghệ Tĩnh, Phường 25, Quận Bình Thạnh, Hồ Chí Minh', N'Địa chỉ:818/19 Xô Viết Nghệ Tĩnh, phường 25, quận Bình Thạnh. 
Vị trí nằm ngay gần công viên thanh đa ngay cầu vượt thanh đa, Gần nhiều trường học như: ĐH Hutech, ĐH Giao thông Vận Tải, ĐH Ngoại Thương, ĐH Hồng Bàng, trường tiểu học Hồng Hà, trường THPT Hồng Đức.... 
+ cách công viên thanh đa 3 phút đi bộ
- Nhà sạch sẽ, full tiện nghi, có ban công, bảo vệ 24/24. 
- Chỉ khoảng 5p tới bến xe Miền Đông nên chỉ khoảng 10p đi xe. Khoảng 15p tới ngay sân bay Tân Sơn Nhất. Gần công vien thanh đa  có thể vui chơi giải trí cuối tuần. 
- Rạp chiếu phim CGV chỉ mất 10p thôi. 
- Chỉ mất 10 - 15p để qua các Quận 1, Quận 2, Gò Vấp, Thủ Đức.... 
Nội thất: 
- Nệm cao su no cao cấp, rộng rãi tạo giấc ngủ thoải mái. 
- Bàn gỗ hiện đại tạo cảm giác sang trọng và hiện đại. 
- Máy lạnh hiện đại không lo nắng nóng Sài Gòn. 
- Tủ lạnh Toshiba hiện đại, tiết kiệm điện và bảo quản đồ ăn tốt, ngon hơn. Tủ lạnh lớn
- Máy nước nóng. 
- Đặc biệt, máy giặt và sân thượng rộng rãi thoáng mát giúp đồ mau khô 
- Chổ để xe rộng rãi 
- Giờ giất tự do thoải mái
- khóa bằng vân tay công nghệ
- Có camera giám sát 24/24
Giá cực ưu đãi chỉ ngay hôm nay 4tr/tháng.
Còn chần chờ gì nữa, nhanh tay liên hệ Mr Hậu 0976671582 để tạn hưởng không gian tuyệt vời này nào!', N'106.713212', N'10.805309')
INSERT [dbo].[tbl_MotelRoom] ([ID], [Name], [UserID], [Address], [Information], [Longitude], [Latitude]) VALUES (N'H008', N'Cho Thuê Phòng Trọ Xinh Đầy Đủ Tiện Nghi, New 100% Ngay Công Viên Thanh Đa Bình Thạnh
', N'phu123', N'860/58 Đường Xô Viết Nghệ Tĩnh, Phường 25, Quận Bình Thạnh, Hồ Chí Minh', N'Được tự do nấu món ăn mình thích? 
- Bạn bè đến chơi thoải mái? 
- An ninh? 
== Đặc Biệt: phòng mới xây tất cả nội thất đều mới chưa bóc tem và được vận hành bởi cty chuyên cho thuê phòng và Quản lí phòng ZACOLAND
Địa chỉ:860/58 Xô Viết Nghệ Tĩnh, phường 25, quận Bình Thạnh. 
Vị trí nằm ngay gần công viên thanh đa ngay cầu vượt thanh đa, Gần nhiều trường học như: ĐH Hutech, ĐH Giao thông Vận Tải, ĐH Ngoại Thương, ĐH Hồng Bàng, trường tiểu học Hồng Hà, trường THPT Hồng Đức.... 
+ cách công viên thanh đa 3 phút đi bộ
- Nhà sạch sẽ, full tiện nghi, có ban công, bảo vệ 24/24. 
- Chỉ khoảng 5p tới bến xe Miền Đông nên chỉ khoảng 10p đi xe. Khoảng 15p tới ngay sân bay Tân Sơn Nhất. Gần công vien thanh đa  có thể vui chơi giải trí cuối tuần. 
- Rạp chiếu phim CGV chỉ mất 10p thôi. 
- Chỉ mất 10 - 15p để qua các Quận 1, Quận 2, Gò Vấp, Thủ Đức.... 
Nội thất: 
+Nệm cao su no cao cấp, rộng rãi tạo giấc ngủ thoải mái. 
+Bàn gỗ hiện đại tạo cảm giác sang trọng và hiện đại. 
+Máy lạnh hiện đại không lo nắng nóng Sài Gòn. 
+Tủ lạnh Toshiba hiện đại, tiết kiệm điện và bảo quản đồ ăn tốt, ngon hơn. Tủ lạnh lớn
+Máy nước nóng. 
+Đặc biệt, máy giặt và sân thượng rộng rãi thoáng mát giúp đồ mau khô 
+Chổ để xe rộng rãi 
+Giờ giất tự do thoải mái
+ khóa bằng vân tay công nghệ
+ Có camera giám sát 24/24
Giá cực ưu đãi chỉ ngay hôm nay 5tr/tháng.
Còn chần chờ gì nữa, nhanh tay liên hệ Mr Hậu 0976671582 để xem phòng và tận hưởng căn phòng của chính bạn!', N'106.7115119999', N'10.8031453')
INSERT [dbo].[tbl_MotelRoom] ([ID], [Name], [UserID], [Address], [Information], [Longitude], [Latitude]) VALUES (N'H009', N'Cho Thuê Phòng Ký Túc Xá Cao Cấp Chuẩn Nhật Bản tại Ung Văn Khiêm, Bình Thạnh
', N'phu123', N'48/10 Ung Văn Khiêm Phường 25 Quận Bình Thạnh.', N'Vị Trí: 48/10 Ung Văn Khiêm Phường 25 Quận Bình Thạnh.

-	Gần nhiều trường học như: ĐH Hutech,ĐH Hồng Bàng, ĐH Giao thông Vận Tải, ĐH Ngoại Thương, UEF, 
-	Gần Vinhomes,Vincom, Landmark 81, TTTM Gigamall… và vô số cửa hàng tiện lợi như Ministop,Familimart Bách hóa xanh, Vinmart xung quanh.
-Phòng rộng 40m2, mỗi phòng có 6 giường cho 6 người.
- Có trang bị tủ quần áo riêng, kệ đựng hồ sơ, bàn làm việc, tủ cá nhân riêng.
- Bếp nấu ăn riêng rộng rãi và thoải mái
- Nhà vệ sinh riêng được dọn vệ sinh hằng ngày rất thoải mái và tiện lợi.
-Camera an ninh 24/24 được cấp quyền xem nơi để xe. trang bị khóa cửa vân tay hiện đại.
- Có chỗ để xe trong nhà rộng rãi. Khu dành cho dân văn phòng, người đi làm, được ưu tiên chỗ đậu.
- Dịch vụ dọn vệ sinh hằng ngày, thay chăn ga gối nệm.
- wifi tốc độ cao miễn phí sài thả ga.
- Giờ giấc tự do, Có khu vực phòng khách dành cho bạn bè đến chơi hoặc nấu ăn chung dịp cuối tuần, lễ, sinh nhật ....
- Giá: 1,5 tr/ tháng và quá nhiều tiện ích cho bạn
  Bạn Hãy nhanh tay liên hệ Mr TÚ: 0911101704 để được lên lịch hẹn giờ đến xem phòng và tư vấn kĩ hơn,', N'106.72320400000001', N'10.801779')
INSERT [dbo].[tbl_MotelRoom] ([ID], [Name], [UserID], [Address], [Information], [Longitude], [Latitude]) VALUES (N'H010', N'Kí túc xá tiêu chuẩn NHẬT BẢN,FREE điện nước sát trường Hutech Q Bình Thạnh.', N'phu123', N'358 Xô Viết Nghệ Tĩnh Phường 25 Quận Bình Thạnh', N'Vị Trí: 358 Xô Viết Nghệ Tĩnh Phường 25 Quận Bình Thạnh.
✔ KÝ TÚC XÁ BÊN MÌNH DÀNH CHO NHỮNG AI?
+Học sinh, sinh viên, người đi làm, nhân viên văn phòng
+Người thu nhập thấp, chỉ cần nơi để ngủ, người tiết kiệm tiền,...
+Mọi độ tuổi từ già, trẻ, lớn, bé đều không phân biệt
+Không chứa các thành phần bất hảo, trộm cắp, bệnh hoạn, biến thái,...
✔ TIỆN NGHI ĐẦY ĐỦ CHO CÁC BẠN SINH HOẠT HẰNG NGÀY:
+Hệ thống giường 2 tầng tiết kiệm tối đa diện tích
+Tủ locker chắc chắn đựng tài sản quý giá
+Móc treo quần áo
+Ổ điện riêng cho mỗi giường, khỏi sợ đang nhắn tin với crush mà hết pin
+Rèm che cho mỗi tầng đảm bảo không gian riêng tư
✔ TIỆN ÍCH CAO CẤP NHƯ KHÁCH SẠN 5 SAO
+Hệ thống camera an ninh hoạt động 24/24
+Máy lạnh và quạt đảo các phòng
+Bãi gữ xe rộng rãi có bảo vệ và camera an ninh, xảy ra mất mát bên mình hoàn toàn chịu trách nhiệm
+Dịch vụ giặt sấy có người đem đến tận phòng chi phí cực kì rẻ
+Dịch vụ quét dọn vệ sinh free mỗi ngày
+Đường dây internet tốc độ cao free dành cho các bạn
✔ TẠI SAO PHẢI Ở KÝ TÚC XÁ BÊN MÌNH? VÌ:
+Có hợp đồng rõ ràng, không lo lừa đảo
+Roomate thân thiện, hòa đồng
+Chủ trọ dễ thương, luôn giúp đỡ các bạn khi cần
+Nằm tại các điểm trung tâm của TPHCM, khu dân trí cao, an ninh tuyệt đối
ĐẶC BIỆT: Chỉ với 1,8 tr/thang là bạn có thể sử dụng TẤT CẢ các dịch vụ trên mà không cần lo phát sinh (  Thỏa mái sử dụng mà KHÔNG cần lo thâm hụt tiền phòng ).
  Bạn Hãy nhanh tay liên hệ Mr TÚ: 0911101704 để được lên lịch hẹn giờ đến xem phòng và tư vấn kĩ hơn,', N'106.71155299999998', N'10.8038399')
INSERT [dbo].[tbl_MotelRoom] ([ID], [Name], [UserID], [Address], [Information], [Longitude], [Latitude]) VALUES (N'H011', N'Phòng trọ cho thuê đường D2 bình thạnh FULL nội thất mới xây
', N'phu123', N'Đường D2, Phường 25, Quận Bình Thạnh, Hồ Chí Minh', N'Mình cần cho thuê phòng trọ mới xây đường D2, 
Chính chủ cho thuê
Giờ giấc tự do giá 4tr8 có phòng không gác và 5tr5 phòng có gác ( Y hình )
an ninh 24/7 có bảo vệ ,ra vào vân tay . 
full nội thất : Tủ lanh , bàn ghế , máy lạnh , máy giặc, giường , bàn kệ ghế. 
Có thang máy cho lầu cao 
ai cần liên hệ mình nhé !', N'106.71597139999994', N'10.8058277')
INSERT [dbo].[tbl_MotelRoom] ([ID], [Name], [UserID], [Address], [Information], [Longitude], [Latitude]) VALUES (N'H012', N'Phòng cho thuê Xô Viết Nghệ Tĩnh, thoáng mát, sạch sẽ, an ninh
', N'phu123', N'378 Xô Viết Nghệ Tĩnh, P. 25, Q. Bình Thạnh.', N'Địa chỉ: 378 Xô Viết Nghệ Tĩnh, P. 25, Q. Bình Thạnh.
+ Mặt tiền đường ngay  Hàng Xanh
+ Nằm ngay ngã ba Xô Viết Nghệ Tĩnh và Bạch Đằng
+ Nằm gần trường các trường Đại học: Hutech, Hồng Bàng, Kinh Tế Tài Chính…

* Giá:
-Phòng: 4,8 triệu / tháng - DT: 25m2
+ Điện: 4000đ/ kí
+ Nước 100k/ người

*Tiện nghi:
+ Máy lạnh 
+ Máy nước nóng
+ Máy giặc
+ Máy nước nóng
+ Tủ gỗ
+ Bàn, ghế
+ Giường nệm

*Tiện ích chung:
+ Giờ giấc tự do, có camera quan sát.
+ Để xe trong nhà miễn phí
+ Có thể nấu ăn trong phòng.
+ Có người dọn vệ sinh khu vực chung mỗi tuần 2 lần.
+ Có đội ngũ bảo trì nhiệt tình.

Liên hệ: 0906868704 (A.Vẫn)
Chúc quý khách có một ngày học tập và làm việc hiệu quả!', N'106.71200210000006', N'10.8045293')
INSERT [dbo].[tbl_MotelRoom] ([ID], [Name], [UserID], [Address], [Information], [Longitude], [Latitude]) VALUES (N'H013', N'Phòng cho thuê full nội thất, có bảo vệ, ban công, quận Bình Thạnh
', N'phu123', N'378 Xô Viết Nghệ Tĩnh, Phường 25, Bình Thạnh', N'Cho thuê phòng full nội thất tại 378 Xô Viết Nghệ Tĩnh, Phường 25, Bình Thạnh

Nhà mình hiện đang trống phòng đầy đủ tiện nghi, ban công và cửa sổ bắt sáng tự nhiên tạo không gian thoáng đãng, thoải mái giúp bạn thư giãn sau những giờ làm việc căng thẳng.

- Vị trí trung tâm thành phố, ngay cầu vượt Hàng Xanh, liền kề Q1, thuận tiện giao thông mọi khu vực, chỉ mất 5p đi: Phú Nhuận, Quận 1, Q2, Q3,....

- Khu vực an ninh, kinh doanh sầm uất, nhiều quán ăn và tiện ích khác.

- Thích hợp cho nhân viên văn phòng và sinh viên văn minh lịch sự.

- Phòng đẹp có nhà vệ sinh riêng, tiện nghi.

- Ngay cạnh công viên bờ kè thoáng mát, trong lành, thích hợp tập thể dục mỗi sáng.

* Hãy bắt đầu cuộc sống lành mạnh tại không gian sống hoàn toàn mới thôi nào.

Các tiện ích đã có sẵn:
. Máy lạnh.
. Giường 1,6m, đệm, drap mền gối.
. Tủ quần áo gỗ 2 cửa.
. Tủ lạnh.
. Máy nước nóng.
. Máy giặt.
. Wifi cực mạnh.
. Kệ bếp nấu ăn rộng rãi.
. Toilet riêng biệt từng phòng.
. Giờ giấc tự do.
. Có lao công dọn vệ sinh khu vực chung 2 lần/tuần.

Giá phòng:
. Phòng loại 30m2: Giá 5.5tr/tháng.
. Điện: 4000 đ/kwh.
. Internet: 100.000 đ/phòng.
. Nước: 100.000 đ/người.

Liên hệ ngay: 090.6868.704 gặp Vẫn để được xem phòng nhé', N'106.71149250000008', N'10.8042102')
INSERT [dbo].[tbl_MotelRoom] ([ID], [Name], [UserID], [Address], [Information], [Longitude], [Latitude]) VALUES (N'H014', N'PHÒNG CHO THUÊ HÀNG XANH, MỚI XÂY 100%, CÓ BẢO VỆ, THANG MÁY, CÓ GÁC LỬNG
', N'phu123', N'48/10 Đường Ung Văn Khiêm, Phường 25, Bình Thạnh ', N'Căn hộ mini mới xây dựng 100%, nhà có thang máy, bảo vệ. Phòng có gác ở được 2-3 người.
-Địa chỉ:48/10 Đường Ung Văn Khiêm, Phường 25, Bình Thạnh 
 + Nằm sát bên trường ĐH HUTECH và Ngoại Thương.
 + Qua ĐH Hồng Bàng và Kinh Tế Tài Chính 5p
 + Sang Q1, Q3 mất 15p. Q2 mất 10p
 + Gần khu vui chơi ăn uống của sinh viên
 + Thông qua đường D5 và D2
- Giá thuê: 5tr/ tháng ( có thương lượng)
 + Điện: 3500/ ki
 + Nước: 20.000/ Khối
- Diện tích: 20m2
 + Có gác lửng 
- Tiện nghi:
 + Máy lạnh mới hoàn toàn tiết kiệm điện
 + Máy nước nóng cho ngày trở lạnh
 + Bếp nấu ăn
 + Nệm cho giấc ngủ êm ái
 + Quạt máy giúp phòng thoáng hơn
 + Thang máy giúp di chuyển thuận lợi hơn
 + Wifi tốc độ cao dễ dàng làm việc
Liên hệ: Mr Vẫn: 0906868704 để xem phòng 24/7
 + Hỗ trợ nhiệt tình không mất phí môi giới
 + Hiện tại chỉ còn 3 phòng trống
 + Hãy nhanh tay liên hệ xem phòng và sỡ hữu ngay căn hộ mini mới xây tuyệt vời này.', N'106.71880609999994', N'10.8070065')
INSERT [dbo].[tbl_MotelRoom] ([ID], [Name], [UserID], [Address], [Information], [Longitude], [Latitude]) VALUES (N'H015', N'Phòng cho thuê đường d2, full nội thất, an ninh, đường lớn.
', N'phu123', N'213 đường d2, Phường 25, Bình Thạnh.', N'- Gần các trường đại học Hutech, Hồng Bàng, Kinh Tế Tài Chính, Ngoại Thương..
- Đi lại quận 1,2 chỉ mất 5p
- Nằm gần vị trí trung tâm hàng xanh
Giá: 4,7tr/ tháng
Diện tích: 22m2 ( có gác)
Tịch ích:
- Máy lạnh
- Gác
- Tủ lạnh
- Máy nước nóng
- Giường nệm
- Máy giặc
- Bếp nấu ăn
Liên hệ: 090.6868.704 Mr. Vẫn để xem phòng và đặt cọc căn phòng này
Hiện tại chỉ trống 1 phòng. giới hạn 2 người ở.', N'106.71613709999997', N'10.8067678')
INSERT [dbo].[tbl_MotelRoom] ([ID], [Name], [UserID], [Address], [Information], [Longitude], [Latitude]) VALUES (N'H016', N'Phòng mới xây, có gác, bảo vệ 24/24, thoáng mát,
', N'phu123', N'48 Ung Văn Khiêm, P25, Q. Bình Thạnh, TP HCM.', N'Vị trí: 48 Ung Văn Khiêm, P25, Q. Bình Thạnh, TP HCM.
- Gần các trường đại học lớn, cách Hutech 5p, đại học GTVT 5p, ĐH Ngoại Thương 5p.

- Ngay trung tâm quận Bình Thạnh, gần bến xe Miền Đông....
-Thuận tiện đi lại các quận 1,2,3..

Thông tin về căn phòng của chúng tôi:

- Diện tích phòng từ 25m2 thích hợp ở hộ gia đình hoặc các bạn sinh viên học tập.

- Phòng có nệm, bàn ghế, bếp, máy lạnh, quạt …

- Toilet riêng biệt, sang trọng.

- Cửa sổ, ban công, cực kỳ thoáng mát, ánh sáng tự nhiên vào phòng, ngày không cần mở đèn.

- Phòng ốc mới sơn cực kỳ sạch, thoáng, đẹp.

- Phòng trang bị sẵn máy lạnh, giúp mùa hè luôn mát mẻ.

- Lối đi riêng, không chung chủ, giờ giấc tự do.

- Có chỗ để xe rộng rãi, an ninh tuyệt đối.

- Tôi xin cam kết với bạn khi bạn sở hữu dịch vụ tuyệt vời căn phòng của bạn, bạn sẽ sang trọng và thoải mái hơn khi trải nghiệm....

- Chúng tôi thường xuyên vệ sinh phòng ốc của bạn vì bạn là khách hàng yêu quý của chúng tôi.

Giá thuê: Chỉ từ 5,5tr/th (chính chủ cho thuê)

- Liên hệ: 090.6868.704 (anh Vẫn) để được xem phòng và giữ cho mình một căn phòng tuyệt vời của riêng bạn. (24/24).', N'106.72054400000002', N'10.804843')
INSERT [dbo].[tbl_MotelRoom] ([ID], [Name], [UserID], [Address], [Information], [Longitude], [Latitude]) VALUES (N'H017', N'Phòng trọ Bình Thạnh gần hàng xanh 25m2
', N'phu123', N'Đường D2, Phường 25, Quận Bình Thạnh, Hồ Chí Minh', N'Phòng trọ quận bình thạnh gần hàng xanh
- Giá thuê: 4,5tr/tháng khép kín (cọc 1 tháng)
- Có máy lạnh, cửa sổ rèm
- Chỗ để xe rộng rãi (không thu phí)
- Khu vực an ninh trật tự
- Giờ giấc tự do thoải mái, không chung chủ
- Gần các trường đại học: Hutech, Giao thông vận tải, ngoại thương, Hồng Bàng,.....
- Gần hàng xanh 700m, Bến xe buýt, Landmark81
- Xung quanh là các cửa hàng tiện ích, chợ, bệnh viện, siêu thị
Liên hệ xem phòng 0938563802', N'106.71597139999994', N'10.8058277')
INSERT [dbo].[tbl_MotelRoom] ([ID], [Name], [UserID], [Address], [Information], [Longitude], [Latitude]) VALUES (N'H018', N'Kí túc xá cho thuê ĐẦY ĐỦ tiện nghi, giá sinh viên, Nguyễn xí-Bình Thạnh
', N'phu123', N'82 Đường Nguyễn Xí, Phường 25, Quận Bình Thạnh, Hồ Chí Minh', N'Bạn là sinh viên ĐH Hutech, ĐH Hồng Bàng, ĐH Giao thông Vận Tải, ĐH Ngoại Thương, UEF… đang tìm kiếm phòng KTX với các tiện nghi như
-	Nội thất ĐẦY ĐỦ, tiện nghi
-	Giờ giấc TỰ DO, không ở chung với chủ ( tha hồ kiếm việc làm thêm, cải thiện thu nhập mà không sợ chủ nhà khóa cửa )
-	MIỄN PHÍ điện, nước, wifi…
-	Bãi đậu xe rộng rãi.
-	Nhà đẹp, thoát mát
-	Hàng xóm xinh đẹp và thân thiện
-	Khu tự học rộng rãi, thoát mát
-	 Văn hóa ký túc xá văn minh và lịch sự giúp bạn thoải mái nghỉ ngơi sau những giờ học tập mệt mỏi
-	An ninh ký túc xá luôn được đảm bảo vì có hệ thống camera và bảo vệ 24/24.
-	 Tổ chức sinh hoạt hằng tuần, hằng tháng để gắn kết các thành viên nhằm tạo ra sự đoàn kết trong ngôi nhà ký túc xá.
-	Quản lý xử lý sự cố nhiệt tình và nhanh chóng

ĐẶC BIỆT: Chỉ với 1,8 tr/thang là bạn có thể sử dụng TẤT CẢ các dịch vụ trên mà không cần lo phát sinh (  Thỏa mái sử dụng mà KHÔNG cần lo thâm hụt tiền phòng ).
           Bạn Hãy nhanh tay liên hệ Mr TÚ: 0911101704 để được lên lịch hẹn giờ đến xem phòng và tư vấn kĩ hơn,', N'106.70651900000007', N'10.8166398')
INSERT [dbo].[tbl_MotelRoom] ([ID], [Name], [UserID], [Address], [Information], [Longitude], [Latitude]) VALUES (N'H019', N'Phòng cho thuê FULL nội thất,tiện nghi,phòng GYM,bảo vệ 24/24 UVK BT
', N'phu123', N'48 Ung Văn Khiêm, phường 25, quận Bình Thạnh.', N'Địa chỉ: 48 Ung Văn Khiêm, phường 25, quận Bình Thạnh.
- Cách trung tâm Q1, Q2,Q3 Phú Nhuận 3 phút di chuyển 
- Gần nhiều trường học như: ĐH Hutech,ĐH Hồng Bàng, ĐH Giao thông Vận Tải, ĐH Ngoại Thương, UEF.
- Ngay cạnh khu trung tâm mua sắm Pearl Plaza, Saigon Pearl, Vincom,Landmart 81…
Tiện ích:
- Thiết kế không gian mở, thoáng mát, hiện đại, các phòng có cửa sổ lấy ánh sáng tự nhiên.
- Phòng rộng 25m2 , riêng biệt không chung chủ, giờ giấc tự do.
- Wifi tốc độ cao, truyền hình cáp.
- Phòng có đầy đủ nội thất như
+ Giường nệm êm ái
+ Tủ quần áo sự ngăn nắp gọn gàng.
+ Tủ lạnh cho bạn thực phẩm mát lạnh.
+ Điều hòa Daikin tiết kiệm điện năng
+ Kệ bếp rộng rãi cho bạn thỏa mái nấu ăn
+ WC riêng cho bạn sự riêng tư thoải mái.
- Di chuyển lên các tầng bằng thang máy hoặc thang bộ.
- Có chỗ để xe máy dưới hầm rộng 50m2.
- Camera giám sát an ninh 24/24, có bảo vệ trực đêm.
- Dịch vụ dọn vệ sinh 3 lần/tuần khu vực công cộng.

Chỉ với 6,5 triệu/tháng và quá nhiều tiện ích cho bạn
Bạn Hãy nhanh tay liên hệ Mr TÚ :0911101704 để được lên lịch hẹn giờ đến xem phòng và tư vấn kĩ hơn,', N'106.72054400000002', N'10.804843')
INSERT [dbo].[tbl_MotelRoom] ([ID], [Name], [UserID], [Address], [Information], [Longitude], [Latitude]) VALUES (N'H020', N'Phòng mới xây 100%,có gác lửng,FULL nội thất chưa bóc tem 5tr XVNT Bình Thạnh.
', N'phu123', N'451 Đường Xô Viết Nghệ Tĩnh, Phường 25, Quận Bình Thạnh, Hồ Chí Minh', N'Phòng cho những công dân văn minh, trí thức tại: 451 Xô Viết Nghệ Tĩnh, P25, Quận Bình Thạnh, TP HCM.
Bạn muốn tìm một phòng trọ tiện nghi với nội thất cao cấp?
Với một vị trí vô cùng thuận tiện để vào quận 1 với 5 phút, ra vào các trục đường chính một cách dễ dàng mà không sợ bị kẹt xe?
Có những người hàng xóm văn minh, trí thức, lịch sự?
Tự do giờ giấc và an ninh tuyệt đối 24/24?
Hãy đến với chúng tôi và bạn sẽ có tất cả những gì bạn cần.
- Vị trí nằm gần trung tâm thành phố (cách 1km), với các trung tâm thương mại, dịch vụ giải trí tuyệt vời xung quanh. Gần các trường đại học: Hutech, Đại Học Tôn Đức Thắng, Đại Học Kinh Tế - Tài Chính TP. HCM (UEF), trường Đại học Giao Thông Vận Tải TP. Hồ Chí Minh, trường Đại học Ngoại Thương cơ sở 2. Gần bến xe Miền Đông, Pearl Plaza, nhà sách 
- Nội thất hiện đại, tiện nghi khách sạn.
- Thuận tiện cho công việc, học hành mà không phải đi đâu xa.
- Đặc biệt vị trí này phù hợp với khách nước ngoài và trong nước vô cùng sang trọng lịch sự.
Tiện ích:
- Có lối đi riêng giúp bạn thuận tiện di chuyển, vô cùng tiện lợi.
- Có gác lửng tiện nghi
- Giường nệm cho bạn giấc ngủ thoải mái.
- Tủ gỗ mới giúp bạn sắp xếp quần áo gọn gàng ngăn nắp hơn.
- Máy lạnh cho bạn sự mát mẻ những ngày hè.
- Tủ lạnh giúp bạn bảo quản thực phẩm tốt hơn.
- Máy giặt giúp bạn tiết kiệm thời gian không phải giặt giũ + sân thượng có sân phơi quần áo.
Giá thuê: 5 triệu/tháng.
Còn chần chừ gì nữa!
Bạn Hãy nhanh tay liên hệ Mr TÚ :0911101704 để được lên lịch hẹn giờ đến xem phòng và tư vấn kĩ hơn,', N'106.71140600000001', N'10.806661')
INSERT [dbo].[tbl_User] ([UserID], [UserName], [PhoneNumber], [Email], [IDCardNumber], [Address], [Password], [Type]) VALUES (N'100418901977794691995', N'Nguyễn Huỳnh Phú', N'', NULL, N'', N'', N'', 3)
INSERT [dbo].[tbl_User] ([UserID], [UserName], [PhoneNumber], [Email], [IDCardNumber], [Address], [Password], [Type]) VALUES (N'108223590815883456808', N'Nguyen Huynh Phu z', N'', NULL, N'', N'', N'', 3)
INSERT [dbo].[tbl_User] ([UserID], [UserName], [PhoneNumber], [Email], [IDCardNumber], [Address], [Password], [Type]) VALUES (N'391325641766601', N'Nguyễn Huỳnh Phú', N'', NULL, N'', N'', N'', 2)
INSERT [dbo].[tbl_User] ([UserID], [UserName], [PhoneNumber], [Email], [IDCardNumber], [Address], [Password], [Type]) VALUES (N'phu123', N'Nguyễn Huỳnh Phú', N'0836867529', N'phunh985@gmail.com', NULL, N'HCM', N'123', 1)
ALTER TABLE [dbo].[tbl_MotelRoom]  WITH CHECK ADD  CONSTRAINT [FK_tbl_MotelRoom_tbl_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[tbl_User] ([UserID])
GO
ALTER TABLE [dbo].[tbl_MotelRoom] CHECK CONSTRAINT [FK_tbl_MotelRoom_tbl_User]
GO
ALTER TABLE [dbo].[tbl_RoomImages]  WITH CHECK ADD  CONSTRAINT [FK_tbl_RoomImages_tbl_Rooms] FOREIGN KEY([RoomID])
REFERENCES [dbo].[tbl_Rooms] ([RoomID])
GO
ALTER TABLE [dbo].[tbl_RoomImages] CHECK CONSTRAINT [FK_tbl_RoomImages_tbl_Rooms]
GO
ALTER TABLE [dbo].[tbl_Rooms]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Rooms_tbl_MotelRoom] FOREIGN KEY([MotelRoomID])
REFERENCES [dbo].[tbl_MotelRoom] ([ID])
GO
ALTER TABLE [dbo].[tbl_Rooms] CHECK CONSTRAINT [FK_tbl_Rooms_tbl_MotelRoom]
GO
USE [master]
GO
ALTER DATABASE [MotelRoomManagement] SET  READ_WRITE 
GO
