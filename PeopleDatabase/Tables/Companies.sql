CREATE TABLE [dbo].[Companies](
[ID] [uniqueidentifier] NOT NULL,
	[CompanyID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [nvarchar](100) NOT NULL,
	[CompanyRoleName] [nvarchar](255) NULL,
	[CompanyTheme] [nvarchar](25) NULL,
	[CompanyEmail] [nvarchar](255) NULL,
	[PaymentMethodDefault] [int] NULL,
	[URL] [nvarchar](225) NULL,
	[CompanyLogo] [nchar](100) NULL,
	[CreatedDateUtc] [datetime] NULL,
	[CreatedBy] [nvarchar](150) NULL,
	[LastModifiedBy] [nvarchar](150) NULL,
	[LastModifiedDateUtc] [datetime] NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [Company_PK] PRIMARY KEY CLUSTERED 
(
	[CompanyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[Companies] ADD  DEFAULT (newid()) FOR [ID]
GO
ALTER TABLE [dbo].[Companies] ADD  DEFAULT (getutcdate()) FOR [CreatedDateUtc]
GO
ALTER TABLE [dbo].[Companies] ADD  DEFAULT (getutcdate()) FOR [LastModifiedDateUtc]
GO
ALTER TABLE [dbo].[Companies] ADD  DEFAULT ((0)) FOR [Deleted]
GO
