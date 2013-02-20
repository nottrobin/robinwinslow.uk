'Examine.ExamineManager' threw an exception
===

This is usually because of permissions.

 - Check what user your App Pool is running as
   IIS Manager -> Your site -> Authentication -> "Anonymous authentication" -> Edit
   User is visible under "Specific user", or if "Application pool identity" is selected, it's probably IIS_IUSRS
 - Make sure this user has full write access to the whole site directory
 - Make sure this user has full write access to C:\Windows\Temp
 - Delete <siteRoot>\App_Data\TEMP\ExamineIndexes
 - Restart the server

This should fix it.

Thanks to [daveb.84](http://our.umbraco.org/forum/developers/razor/24343-'ExamineExamineManager'-threw-an-exception#comment91058).


