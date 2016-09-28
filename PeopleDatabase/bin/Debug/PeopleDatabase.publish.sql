﻿/*
Deployment script for ThePeopelSearchApplication

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "ThePeopelSearchApplication"
:setvar DefaultFilePrefix "ThePeopelSearchApplication"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL 
            WITH ROLLBACK IMMEDIATE;
        
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET PAGE_VERIFY NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Creating [dbo].[Addresses]...';


GO
CREATE TABLE [dbo].[Addresses] (
    [ID]              UNIQUEIDENTIFIER NOT NULL,
    [AddressID]       INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ContactID]       INT              NOT NULL,
    [AddressTypeID]   INT              NOT NULL,
    [Name]            VARCHAR (100)    NULL,
    [Street1]         VARCHAR (255)    NULL,
    [Street2]         VARCHAR (255)    NULL,
    [City]            VARCHAR (255)    NULL,
    [PostalCode]      VARCHAR (10)     NULL,
    [County]          VARCHAR (255)    NULL,
    [StateProvinceID] INT              NULL,
    [SPSAddressID]    VARCHAR (50)     NULL,
    [IsResidential]   BIT              NOT NULL,
    [Deleted]         BIT              NOT NULL,
    CONSTRAINT [PK_Addresses] PRIMARY KEY CLUSTERED ([AddressID] ASC) ON [PRIMARY]
);


GO
PRINT N'Creating [dbo].[Centers]...';


GO
CREATE TABLE [dbo].[Centers] (
    [ID]                  UNIQUEIDENTIFIER NOT NULL,
    [CenterID]            INT              IDENTITY (1, 1) NOT NULL,
    [CenterName]          NVARCHAR (100)   NOT NULL,
    [CompanyID]           INT              NULL,
    [AddressID]           INT              NULL,
    [URL]                 NVARCHAR (255)   NULL,
    [AuthorizeNetLogin]   NVARCHAR (50)    NULL,
    [AuthorizeNetTranKey] NVARCHAR (50)    NULL,
    [Deleted]             BIT              NOT NULL,
    [CenterLogo]          IMAGE            NULL,
    [CybersourceLogin]    NVARCHAR (50)    NULL,
    [CybersourceTranKey]  NVARCHAR (500)   NULL,
    [AuthorizeNetUrl]     NVARCHAR (255)   NULL,
    [CybersourceUrl]      NVARCHAR (255)   NULL,
    [CreatedDateUtc]      DATETIME         NULL,
    [CreatedBy]           NVARCHAR (150)   NULL,
    [LastModifiedBy]      NVARCHAR (150)   NULL,
    [LastModifiedDateUtc] DATETIME         NULL,
    [MerchantID]          NVARCHAR (50)    NULL,
    [Token]               NVARCHAR (500)   NULL,
    CONSTRAINT [Centers_PK] PRIMARY KEY CLUSTERED ([CenterID] ASC) ON [PRIMARY]
) TEXTIMAGE_ON [PRIMARY];


GO
PRINT N'Creating [dbo].[Companies]...';


GO
CREATE TABLE [dbo].[Companies] (
    [ID]                   UNIQUEIDENTIFIER NOT NULL,
    [CompanyID]            INT              IDENTITY (1, 1) NOT NULL,
    [CompanyName]          NVARCHAR (100)   NOT NULL,
    [CompanyRoleName]      NVARCHAR (255)   NULL,
    [CompanyTheme]         NVARCHAR (25)    NULL,
    [CompanyEmail]         NVARCHAR (255)   NULL,
    [PaymentMethodDefault] INT              NULL,
    [URL]                  NVARCHAR (225)   NULL,
    [CompanyLogo]          NCHAR (100)      NULL,
    [CreatedDateUtc]       DATETIME         NULL,
    [CreatedBy]            NVARCHAR (150)   NULL,
    [LastModifiedBy]       NVARCHAR (150)   NULL,
    [LastModifiedDateUtc]  DATETIME         NULL,
    [Deleted]              BIT              NOT NULL,
    CONSTRAINT [Company_PK] PRIMARY KEY CLUSTERED ([CompanyID] ASC) ON [PRIMARY]
);


GO
PRINT N'Creating [dbo].[Contacts]...';


GO
CREATE TABLE [dbo].[Contacts] (
    [ContactID]    INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [TempInsertID] VARCHAR (255) NULL,
    CONSTRAINT [PK_Contacts] PRIMARY KEY CLUSTERED ([ContactID] ASC) ON [PRIMARY]
);


GO
PRINT N'Creating [dbo].[People]...';


GO
CREATE TABLE [dbo].[People] (
    [PersonID]                 INT            IDENTITY (1, 1) NOT NULL,
    [FirstName]                NVARCHAR (50)  NOT NULL,
    [MiddleName]               NVARCHAR (20)  NULL,
    [LastName]                 NVARCHAR (50)  NOT NULL,
    [NickName]                 NVARCHAR (30)  NULL,
    [Suffix]                   NVARCHAR (5)   NULL,
    [DOB]                      DATETIME       NULL,
    [CreatedDate]              DATETIME       NOT NULL,
    [CreatedDateUtc]           DATETIME       NOT NULL,
    [CreatedBy]                NVARCHAR (510) NOT NULL,
    [PatientID]                INT            NULL,
    [Gender]                   NVARCHAR (1)   NULL,
    [Deleted]                  BIT            NOT NULL,
    [DeletedDate]              DATETIME       NULL,
    [CenterID]                 INT            NOT NULL,
    [PrescriberDefault]        INT            NULL,
    [AddressDefault]           INT            NULL,
    [EmailDefault]             INT            NULL,
    [PhoneNumberDefault]       INT            NULL,
    [IncludeClaimForm]         BIT            NOT NULL,
    [MarketingOptOut]          BIT            NOT NULL,
    [AutoRefill]               BIT            NOT NULL,
    [AutoRenew]                BIT            NOT NULL,
    [RequireOrderConfirmation] BIT            NOT NULL,
    [CreditOnFile]             MONEY          NULL,
    [PaymentMethodDefault]     INT            NULL,
    [AuthorizeNetCustomerID]   NVARCHAR (10)  NULL,
    [CarrierServiceID]         INT            NULL,
    [NoChildProofCaps]         BIT            NOT NULL,
    [SignatureRequired]        BIT            NOT NULL,
    [SignatureDefault]         NVARCHAR (30)  NULL,
    [FullName]                 AS             (([FirstName] + ' ') + [LastName]),
    [SSN]                      NCHAR (20)     NULL,
    [Salutation]               NCHAR (10)     NULL,
    [ImageUrl]                 NVARCHAR (100) NULL,
    CONSTRAINT [Person_PK] PRIMARY KEY CLUSTERED ([PersonID] ASC) ON [PRIMARY]
);


GO
PRINT N'Creating DF_Addresses_IsResidential...';


GO
ALTER TABLE [dbo].[Addresses]
    ADD CONSTRAINT [DF_Addresses_IsResidential] DEFAULT ((0)) FOR [IsResidential];


GO
PRINT N'Creating DF_Addresses_Deleted...';


GO
ALTER TABLE [dbo].[Addresses]
    ADD CONSTRAINT [DF_Addresses_Deleted] DEFAULT ((0)) FOR [Deleted];


GO
PRINT N'Creating DF__Center__Delet__3EC77721...';


GO
ALTER TABLE [dbo].[Centers]
    ADD CONSTRAINT [DF__Center__Delet__3EC77721] DEFAULT ((0)) FOR [Deleted];


GO
PRINT N'Creating Default Constraint on [dbo].[Centers]....';


GO
ALTER TABLE [dbo].[Centers]
    ADD DEFAULT (newid()) FOR [ID];


GO
PRINT N'Creating Default Constraint on [dbo].[Centers]....';


GO
ALTER TABLE [dbo].[Centers]
    ADD DEFAULT (getutcdate()) FOR [CreatedDateUtc];


GO
PRINT N'Creating Default Constraint on [dbo].[Centers]....';


GO
ALTER TABLE [dbo].[Centers]
    ADD DEFAULT (getutcdate()) FOR [LastModifiedDateUtc];


GO
PRINT N'Creating Default Constraint on [dbo].[Companies]....';


GO
ALTER TABLE [dbo].[Companies]
    ADD DEFAULT (newid()) FOR [ID];


GO
PRINT N'Creating Default Constraint on [dbo].[Companies]....';


GO
ALTER TABLE [dbo].[Companies]
    ADD DEFAULT (getutcdate()) FOR [CreatedDateUtc];


GO
PRINT N'Creating Default Constraint on [dbo].[Companies]....';


GO
ALTER TABLE [dbo].[Companies]
    ADD DEFAULT (getutcdate()) FOR [LastModifiedDateUtc];


GO
PRINT N'Creating Default Constraint on [dbo].[Companies]....';


GO
ALTER TABLE [dbo].[Companies]
    ADD DEFAULT ((0)) FOR [Deleted];


GO
PRINT N'Creating DF__People__Creat__46A09EA5...';


GO
ALTER TABLE [dbo].[People]
    ADD CONSTRAINT [DF__People__Creat__46A09EA5] DEFAULT (getdate()) FOR [CreatedDate];


GO
PRINT N'Creating DF__People__Creat__4794C2DE...';


GO
ALTER TABLE [dbo].[People]
    ADD CONSTRAINT [DF__People__Creat__4794C2DE] DEFAULT (getutcdate()) FOR [CreatedDateUtc];


GO
PRINT N'Creating DF__People__Delet__4888E717...';


GO
ALTER TABLE [dbo].[People]
    ADD CONSTRAINT [DF__People__Delet__4888E717] DEFAULT ((0)) FOR [Deleted];


GO
PRINT N'Creating DF_People_IncludeClaimForm...';


GO
ALTER TABLE [dbo].[People]
    ADD CONSTRAINT [DF_People_IncludeClaimForm] DEFAULT ((0)) FOR [IncludeClaimForm];


GO
PRINT N'Creating DF_People_MarketingOptOut...';


GO
ALTER TABLE [dbo].[People]
    ADD CONSTRAINT [DF_People_MarketingOptOut] DEFAULT ((0)) FOR [MarketingOptOut];


GO
PRINT N'Creating DF_People_AutoRefill...';


GO
ALTER TABLE [dbo].[People]
    ADD CONSTRAINT [DF_People_AutoRefill] DEFAULT ((0)) FOR [AutoRefill];


GO
PRINT N'Creating DF_People_AutoRenew...';


GO
ALTER TABLE [dbo].[People]
    ADD CONSTRAINT [DF_People_AutoRenew] DEFAULT ((0)) FOR [AutoRenew];


GO
PRINT N'Creating DF_People_RequireOrderConfirmation...';


GO
ALTER TABLE [dbo].[People]
    ADD CONSTRAINT [DF_People_RequireOrderConfirmation] DEFAULT ((0)) FOR [RequireOrderConfirmation];


GO
PRINT N'Creating DF_People_NoChildProofCaps...';


GO
ALTER TABLE [dbo].[People]
    ADD CONSTRAINT [DF_People_NoChildProofCaps] DEFAULT ((0)) FOR [NoChildProofCaps];


GO
PRINT N'Creating DF_People_SignatureRequired...';


GO
ALTER TABLE [dbo].[People]
    ADD CONSTRAINT [DF_People_SignatureRequired] DEFAULT ((0)) FOR [SignatureRequired];


GO
PRINT N'Creating FK_Addresses_Contacts...';


GO
ALTER TABLE [dbo].[Addresses] WITH NOCHECK
    ADD CONSTRAINT [FK_Addresses_Contacts] FOREIGN KEY ([ContactID]) REFERENCES [dbo].[Contacts] ([ContactID]);


GO
PRINT N'Creating Company_Centers_FK1...';


GO
ALTER TABLE [dbo].[Centers] WITH NOCHECK
    ADD CONSTRAINT [Company_Centers_FK1] FOREIGN KEY ([CompanyID]) REFERENCES [dbo].[Companies] ([CompanyID]);


GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Addresses] WITH CHECK CHECK CONSTRAINT [FK_Addresses_Contacts];

ALTER TABLE [dbo].[Centers] WITH CHECK CHECK CONSTRAINT [Company_Centers_FK1];


GO
PRINT N'Update complete.';


GO
