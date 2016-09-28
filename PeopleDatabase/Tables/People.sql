CREATE TABLE [dbo].[People](
	[PersonID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[MiddleName] [nvarchar](20) NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[NickName] [nvarchar](30) NULL,
	[Suffix] [nvarchar](5) NULL,
	[DOB] [datetime] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedDateUtc] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](510) NOT NULL,
	[PatientID] [int] NULL,
	[Gender] [nvarchar](1) NULL,
	[Deleted] [bit] NOT NULL,
	[DeletedDate] [datetime] NULL,
	[CenterID] [int] NOT NULL,
	[PrescriberDefault] [int] NULL,
	[AddressDefault] [int] NULL,
	[EmailDefault] [int] NULL,
	[PhoneNumberDefault] [int] NULL,
	[IncludeClaimForm] [bit] NOT NULL,
	[MarketingOptOut] [bit] NOT NULL,
	[AutoRefill] [bit] NOT NULL,
	[AutoRenew] [bit] NOT NULL,
	[RequireOrderConfirmation] [bit] NOT NULL,
	[CreditOnFile] [money] NULL,
	[PaymentMethodDefault] [int] NULL,
	[AuthorizeNetCustomerID] [nvarchar](10) NULL,
	[CarrierServiceID] [int] NULL,
	[NoChildProofCaps] [bit] NOT NULL,
	[SignatureRequired] [bit] NOT NULL,
	[SignatureDefault] [nvarchar](30) NULL,
	[FullName]  AS (([FirstName]+' ')+[LastName]),
	[SSN] [nchar](20) NULL,
	[Salutation] [nchar](10) NULL,
	[Interests] nvarchar(250) null,
	[ImageUrl] [nvarchar](100) NULL,
 [ContactID] INT NULL, 
    CONSTRAINT [Person_PK] PRIMARY KEY CLUSTERED 
(
	[PersonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)

GO

ALTER TABLE [dbo].[People] ADD  CONSTRAINT [DF__People__Creat__46A09EA5]  DEFAULT (getdate()) FOR [CreatedDate]
GO

ALTER TABLE [dbo].[People] ADD  CONSTRAINT [DF__People__Creat__4794C2DE]  DEFAULT (getutcdate()) FOR [CreatedDateUtc]
GO

ALTER TABLE [dbo].[People] ADD  CONSTRAINT [DF__People__Delet__4888E717]  DEFAULT ((0)) FOR [Deleted]
GO

ALTER TABLE [dbo].[People] ADD  CONSTRAINT [DF_People_IncludeClaimForm]  DEFAULT ((0)) FOR [IncludeClaimForm]
GO

ALTER TABLE [dbo].[People] ADD  CONSTRAINT [DF_People_MarketingOptOut]  DEFAULT ((0)) FOR [MarketingOptOut]
GO

ALTER TABLE [dbo].[People] ADD  CONSTRAINT [DF_People_AutoRefill]  DEFAULT ((0)) FOR [AutoRefill]
GO

ALTER TABLE [dbo].[People] ADD  CONSTRAINT [DF_People_AutoRenew]  DEFAULT ((0)) FOR [AutoRenew]
GO

ALTER TABLE [dbo].[People] ADD  CONSTRAINT [DF_People_RequireOrderConfirmation]  DEFAULT ((0)) FOR [RequireOrderConfirmation]
GO

ALTER TABLE [dbo].[People] ADD  CONSTRAINT [DF_People_NoChildProofCaps]  DEFAULT ((0)) FOR [NoChildProofCaps]
GO

ALTER TABLE [dbo].[People] ADD  CONSTRAINT [DF_People_SignatureRequired]  DEFAULT ((0)) FOR [SignatureRequired]
GO
ALTER TABLE [dbo].[People]  WITH CHECK ADD  CONSTRAINT [FK_People_Contacts] FOREIGN KEY([ContactID])
REFERENCES [dbo].[Contacts] ([ContactID])
GO
ALTER TABLE [dbo].[People] CHECK CONSTRAINT [FK_People_Contacts]
GO
ALTER TABLE [dbo].[People]  WITH CHECK ADD  CONSTRAINT [FK_People_Addresses] FOREIGN KEY([AddressDefault])
REFERENCES [dbo].[Addresses] ([AddressID])
GO
ALTER TABLE [dbo].[People] CHECK CONSTRAINT [FK_People_Addresses]
GO



