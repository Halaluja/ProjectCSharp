USE [master]
GO
/****** Object:  Database [MotelRoomManagement]    Script Date: 21-Sep-19 8:49:47 PM ******/
CREATE DATABASE [MotelRoomManagement]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MotelRoomManagement', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\MotelRoomManagement.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
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
USE [MotelRoomManagement]
GO
/****** Object:  Table [dbo].[tbl_MotelRoom]    Script Date: 21-Sep-19 8:49:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_MotelRoom](
	[ID] [varchar](10) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](200) NOT NULL,
	[Information] [nvarchar](500) NULL,
	[Longitude] [varchar](max) NOT NULL,
	[Latitude] [varchar](max) NOT NULL,
 CONSTRAINT [PK_tbl_MotelRoom] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_RoomImages]    Script Date: 21-Sep-19 8:49:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_RoomImages](
	[RoomID] [nchar](10) NULL,
	[Path] [varchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_Rooms]    Script Date: 21-Sep-19 8:49:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_User]    Script Date: 21-Sep-19 8:49:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_User](
	[UserID] [nvarchar](50) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[PhoneNumber] [varchar](12) NULL,
	[Email] [varchar](50) NULL,
	[IDCardNumber] [varchar](15) NULL,
	[Address] [nvarchar](100) NULL,
	[Password] [nvarchar](15) NULL,
	[Type] [int] NULL,
 CONSTRAINT [PK_tbl_Owner] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
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
