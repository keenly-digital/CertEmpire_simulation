enum ApiEndpoint {
  register,
  login,
  verifyAccount,
  updateProfile,
  updateProfilePic,
  requestOtp,
  verifyOtp,
  resetPassword,
  changePassword,
  createQuizFile,
  addQuestion,
  editQuestion,
  deleteQuestion,
  exportFile,
  deleteFile,
  uploadFile,
  getQuizFiles,
  startExam,
  submitExam,
  getAllFileQuestions,
  getFileContent,
  getAllQuizzes,
  deleteQuiz,
  addTopic,
  getCaseStudy,
  editTopic,
  deleteTopic,
  addCaseStudy,
  editCaseStudy,
  deleteCaseStudy,
}

extension ApiEndpointPath on ApiEndpoint {
  String get path {
    switch (this) {
      case ApiEndpoint.register:
        return '/User/Signup';
      case ApiEndpoint.login:
        return '/User/Login';
      case ApiEndpoint.requestOtp:
        return '/User/RequestOtp';
      case ApiEndpoint.verifyAccount:
        return '/User/VerifyAccount';
      case ApiEndpoint.updateProfile:
        return '/User/UpdateProfile';
      case ApiEndpoint.updateProfilePic:
        return '/User/UpdateProfilePic';
      case ApiEndpoint.verifyOtp:
        return '/User/VerifyOtp';
      case ApiEndpoint.resetPassword:
        return '/User/ResetPassword';
      case ApiEndpoint.changePassword:
        return '/User/ChangePassword';
      case ApiEndpoint.exportFile:
        return '/Quiz/ExportFile';
      case ApiEndpoint.deleteFile:
        return '/Quiz/';
      case ApiEndpoint.uploadFile:
        return '/Quiz/UploadFile';
      case ApiEndpoint.createQuizFile:
        return '/Quiz/CreateQuizFile';
      case ApiEndpoint.addQuestion:
        return '/Question/AddQuestion';
      case ApiEndpoint.editQuestion:
        return '/Question/EditQuestion';
      case ApiEndpoint.deleteQuestion:
        return '/Question/';
      case ApiEndpoint.getQuizFiles:
        return '/Quiz/GetQuizFile';
      case ApiEndpoint.deleteQuiz:
        return '/Quiz/DeleteQuiz';
      case ApiEndpoint.getAllFileQuestions:
        return '/Quiz/GetAllQuestions';
      case ApiEndpoint.getAllQuizzes:
        return '/Quiz/GetAllQuiz';
      case ApiEndpoint.getFileContent:
        return '/Quiz/GetFileContent';
      case ApiEndpoint.startExam:
        return '/Exam/StartExam';
      case ApiEndpoint.submitExam:
        return '/Exam/SubmitExam';
      case ApiEndpoint.addTopic:
        return "/Topic/AddTopic";
        case ApiEndpoint.getCaseStudy:
        return "/Topic/GetCaseStudyById";
      case ApiEndpoint.editTopic:
        return "/Topic/EditTopic";
      case ApiEndpoint.deleteTopic:
        return "/Topic/DeleteTopic";
      case ApiEndpoint.addCaseStudy:
        return "/Topic/AddCaseStudy";
      case ApiEndpoint.editCaseStudy:
        return "/Topic/EditCaseStudy";
      case ApiEndpoint.deleteCaseStudy:
        return "/Topic/DeleteCaseStudy";
    }
  }
}
