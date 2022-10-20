// shared variables and functions that will be used through any view model
abstract class BaseViewModel extends BaseViewModelInputs with BaseViewModeOutputs{}
abstract class BaseViewModelInputs{
  void start();// start view model job
  void dispose();// will be called when view model dies
}
abstract class BaseViewModeOutputs {

}