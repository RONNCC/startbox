// goes into a new project at script.google.com

function gmailAutoarchive() {
  
  var defaultDelayDays = 7; // will only impact emails more than 48h old

  // all labels to auto archive with days to wait for it
  var labelsToArchive = {
    "Company/Visible"        : 3,
    "Clutter/JIRA"           : 2,
    "Clutter/OTPCodes"       : 1,
    "Clutter/GCalResponses"  : 2,
    "Team/Alerts"            : 2,
    "Team/PWZendesk"         : 3,
    "autoarchive"            : 7,
    "Hiring"                 : 3,
    "News"                   : 5,
    "Team/Expenses"          : 4,
    "Clutter/StaleableNotifs": 4, 
  }

  // from https://gist.github.com/MauricioMoraes/225afcc9dd72acf1511f
  // flatten array -- 
  function flatten(arrayOfArrays){
    return [].concat.apply([], arrayOfArrays);
  }

  // Get all the threads related mapping to those labels
  var threads = flatten(Object.keys(labelsToArchive)
                .map(label => GmailApp.getUserLabelByName(label))
                .filter(label => label != null)
                .map(label => label.getThreads())
                .filter(thread => thread != null)
  );

  var threadsInInbox = threads.filter(thread => thread.isInInbox());
  console.log("Potential # messages to archive: " + threadsInInbox.length);

  // we archive all the threads if they're unread AND older than the limit we set in delayDays
  for (var i = 0; i < threadsInInbox.length; i++) {

    // check which label triggered the archive (we do not deal with multiple labels)
    var labelToUseArray = threadsInInbox[i].getLabels().map(label => label.getName()).filter(label => label in labelsToArchive);

    // calculate via the above dictionary how many days we should wait for it (note this assumes messages have only 1 label)
    var daysToWaitForLabel = labelToUseArray.length > 0 ? labelsToArchive[labelToUseArray[0]] : defaultDelayDays;

    var maxDate = new Date();
    maxDate.setDate(maxDate.getDate() - daysToWaitForLabel); // what was the date at that time?

    // actually archive the message potentially
    if (threadsInInbox[i].getLastMessageDate() < maxDate)
    {
      threadsInInbox[i].moveToArchive();
    }
  }
}
