﻿CREATE TABLE [dbo].[Contacts](
	[ContactID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[TempInsertID] [varchar](255) NULL,
 CONSTRAINT [PK_Contacts] PRIMARY KEY CLUSTERED 
(
	[ContactID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)