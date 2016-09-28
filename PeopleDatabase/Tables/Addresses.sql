CREATE TABLE [dbo].[Addresses](
[ID] [uniqueidentifier] NOT NULL,
	[AddressID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ContactID] [int] NOT NULL,
	[AddressTypeID] [int] NOT NULL,
	[Name] [varchar](100) NULL,
	[Street1] [varchar](255) NULL,
	[Street2] [varchar](255) NULL,
	[City] [varchar](255) NULL,
	[PostalCode] [varchar](10) NULL,
	[County] [varchar](255) NULL,
	[StateProvinceID] [int] NULL,
	[SPSAddressID] [varchar](50) NULL,
	[IsResidential] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_Addresses] PRIMARY KEY CLUSTERED 
(
	[AddressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)

GO
ALTER TABLE [dbo].[Addresses] ADD  CONSTRAINT [DF_Addresses_IsResidential]  DEFAULT ((0)) FOR [IsResidential]
GO
ALTER TABLE [dbo].[Addresses] ADD  CONSTRAINT [DF_Addresses_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[Addresses]  WITH CHECK ADD  CONSTRAINT [FK_Addresses_Contacts] FOREIGN KEY([ContactID])
REFERENCES [dbo].[Contacts] ([ContactID])
GO
ALTER TABLE [dbo].[Addresses] CHECK CONSTRAINT [FK_Addresses_Contacts]
GO


--ALTER TABLE [dbo].[Addresses]  WITH CHECK ADD  CONSTRAINT [FK_Addresses_AddressTypes] FOREIGN KEY([AddressTypeID])
--REFERENCES [dbo].[AddressTypes] ([AddressTypeID])
--GO
--ALTER TABLE [dbo].[Addresses] CHECK CONSTRAINT [FK_Addresses_AddressTypes]
--GO
--ALTER TABLE [dbo].[Addresses]  WITH CHECK ADD  CONSTRAINT [FK_Addresses_StatesProvinces] FOREIGN KEY([StateProvinceID])
--REFERENCES [dbo].[StatesProvinces] ([StateProvinceID])
--GO

--ALTER TABLE [dbo].[Addresses] CHECK CONSTRAINT [FK_Addresses_StatesProvinces]
--GO
