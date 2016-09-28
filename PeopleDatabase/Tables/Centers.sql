
CREATE TABLE [dbo].[Centers](
[ID] [uniqueidentifier] NOT NULL,
	[CenterID] [int] IDENTITY(1,1) NOT NULL,
	[CenterName] [nvarchar](100) NOT NULL,
	[CompanyID] [int] NULL,
	[AddressID] [int] NULL,
	[URL] [nvarchar](255) NULL,
	[AuthorizeNetLogin] [nvarchar](50) NULL,
	[AuthorizeNetTranKey] [nvarchar](50) NULL,
	[Deleted] [bit] NOT NULL,
	[CenterLogo] [image] NULL,
	[CybersourceLogin] [nvarchar](50) NULL,
	[CybersourceTranKey] [nvarchar](500) NULL,
	[AuthorizeNetUrl] [nvarchar](255) NULL,
	[CybersourceUrl] [nvarchar](255) NULL,
	[CreatedDateUtc] [datetime] NULL,
	[CreatedBy] [nvarchar](150) NULL,
	[LastModifiedBy] [nvarchar](150) NULL,
	[LastModifiedDateUtc] [datetime] NULL,
	[MerchantID] [nvarchar](50) NULL,
	[Token] [nvarchar](500) NULL,
 CONSTRAINT [Centers_PK] PRIMARY KEY CLUSTERED 
(
	[CenterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)  TEXTIMAGE_ON [PRIMARY]

GO

ALTER TABLE [dbo].[Centers] ADD  CONSTRAINT [DF__Center__Delet__3EC77721]  DEFAULT ((0)) FOR [Deleted]
GO

ALTER TABLE [dbo].[Centers] ADD  DEFAULT (newid()) FOR [ID]
GO

ALTER TABLE [dbo].[Centers] ADD  DEFAULT (getutcdate()) FOR [CreatedDateUtc]
GO

ALTER TABLE [dbo].[Centers] ADD  DEFAULT (getutcdate()) FOR [LastModifiedDateUtc]
GO

--ALTER TABLE [dbo].[Centers]  WITH CHECK ADD  CONSTRAINT [Address_Centers_FK1] FOREIGN KEY([AddressID])
--REFERENCES [dbo].[Address] ([AddressID])
--GO

--ALTER TABLE [dbo].[Centers] CHECK CONSTRAINT [Address_Centers_FK1]
--GO

ALTER TABLE [dbo].[Centers]  WITH CHECK ADD  CONSTRAINT [Company_Centers_FK1] FOREIGN KEY([CompanyID])
REFERENCES [dbo].[Companies] ([CompanyID])
GO

ALTER TABLE [dbo].[Centers] CHECK CONSTRAINT [Company_Centers_FK1]
GO


