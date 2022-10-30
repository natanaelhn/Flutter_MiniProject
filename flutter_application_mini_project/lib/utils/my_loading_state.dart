abstract class MyLoadingState{

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setIsLoading(bool isLoading){
    _isLoading = isLoading;
  }
}