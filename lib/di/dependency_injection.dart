import 'package:get_it/get_it.dart';
import 'package:way2fitlife/features/chart/data/dataSource/chart_datasource.dart';
import 'package:way2fitlife/features/chart/data/dataSource/chart_datasource_impl.dart';
import 'package:way2fitlife/features/chart/data/repository/chart_repository_impl.dart';
import 'package:way2fitlife/features/chart/domain/repository/chart_repository.dart';
import 'package:way2fitlife/features/chart/domain/usecase/chart_usecase.dart';
import 'package:way2fitlife/features/chart/presentation/bloc/bloc.dart';
import 'package:way2fitlife/features/comment/data/dataresourse/comment_data_resourse.dart';
import 'package:way2fitlife/features/comment/data/dataresourse/comment_data_resourse_iml.dart';
import 'package:way2fitlife/features/comment/data/repository/comment_repository_iml.dart';
import 'package:way2fitlife/features/comment/domian/repository/comment_repository.dart';
import 'package:way2fitlife/features/comment/domian/usecase/comment_use_case.dart';
import 'package:way2fitlife/features/comment/presentation/bloc/add_comment/add_comment_bloc.dart';
import 'package:way2fitlife/features/comment/presentation/bloc/comment_bloc/comment_bloc.dart';
import 'package:way2fitlife/features/compare/data/dataSource/compare_datasource.dart';
import 'package:way2fitlife/features/compare/data/dataSource/compare_datasource_impl.dart';
import 'package:way2fitlife/features/compare/data/repository/compare_repository_impl.dart';
import 'package:way2fitlife/features/compare/domain/repository/compare_repository.dart';
import 'package:way2fitlife/features/compare/domain/usecase/compare_usecase.dart';
import 'package:way2fitlife/features/compare/presentation/bloc/bloc.dart';
import 'package:way2fitlife/features/current_bmi/domain/usecase/current_bmi_usecase.dart';
import 'package:way2fitlife/features/current_bmi/presentation/bloc/bloc.dart';
import 'package:way2fitlife/features/current_bmr/data/datasource/current_bmr_datasource.dart';
import 'package:way2fitlife/features/current_bmr/data/datasource/current_bmr_datasource_impl.dart';
import 'package:way2fitlife/features/current_bmr/data/repository/current_bmr_repository_impl.dart';
import 'package:way2fitlife/features/current_bmr/domain/repository/current_bmr_repository.dart';
import 'package:way2fitlife/features/current_bmr/domain/usecase/current_bmr_usecase.dart';
import 'package:way2fitlife/features/current_bmr/presentation/bloc/bloc.dart';
import 'package:way2fitlife/features/dashboard/data/datasource/dashboard_data_source.dart';
import 'package:way2fitlife/features/dashboard/data/datasource/dashboard_data_source_impl.dart';
import 'package:way2fitlife/features/dashboard/data/repository/dashboard_repository_impl.dart';
import 'package:way2fitlife/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:way2fitlife/features/dashboard/domain/usecases/dashboard_usecase.dart';
import 'package:way2fitlife/features/dashboard/presentation/bloc/bloc.dart';
import 'package:way2fitlife/features/drawer/data/datasource/drawer_data_source.dart';
import 'package:way2fitlife/features/drawer/data/datasource/drawer_data_source_impl.dart';
import 'package:way2fitlife/features/drawer/data/repository/drawer_repository_impl.dart';
import 'package:way2fitlife/features/drawer/domain/repository/drawer_repository.dart';
import 'package:way2fitlife/features/drawer/domain/usecases/drawer_usecase.dart';
import 'package:way2fitlife/features/drawer/presentation/bloc/bloc.dart';
import 'package:way2fitlife/features/feedback/data/dataSource/feedback_datasource.dart';
import 'package:way2fitlife/features/feedback/data/dataSource/feedback_datasource_impl.dart';
import 'package:way2fitlife/features/feedback/data/repository/feedback_repository_impl.dart';
import 'package:way2fitlife/features/feedback/domain/repository/feedback_repository.dart';
import 'package:way2fitlife/features/feedback/domain/usecase/feedback_usecase.dart';
import 'package:way2fitlife/features/feedback/presentation/bloc/bloc.dart';
import 'package:way2fitlife/features/food_directory/data/dataSource/food_directory_datasource.dart';
import 'package:way2fitlife/features/food_directory/data/dataSource/food_directory_datasource_impl.dart';
import 'package:way2fitlife/features/food_directory/data/repository/food_directory_repository_impl.dart';
import 'package:way2fitlife/features/food_directory/domain/repository/food_directory_repository.dart';
import 'package:way2fitlife/features/food_directory/domain/usecase/food_directory_usecase.dart';
import 'package:way2fitlife/features/food_directory/presentation/bloc/bloc.dart';
import 'package:way2fitlife/features/food_directory/presentation/pages/rich_food_directory/data/data_source/rich_food_datasource.dart';
import 'package:way2fitlife/features/food_directory/presentation/pages/rich_food_directory/data/data_source/rich_food_datasource_impl.dart';
import 'package:way2fitlife/features/food_directory/presentation/pages/rich_food_directory/data/repository/rich_food_repository_impl.dart';
import 'package:way2fitlife/features/food_directory/presentation/pages/rich_food_directory/domain/repository/rich_food_repository.dart';
import 'package:way2fitlife/features/food_directory/presentation/pages/rich_food_directory/domain/usecase/rich_food_usecase.dart';
import 'package:way2fitlife/features/food_directory/presentation/pages/rich_food_directory/presentation/bloc/bloc.dart';
import 'package:way2fitlife/features/food_instructions/data/datasource/food_instruction_datasource.dart';
import 'package:way2fitlife/features/food_instructions/data/datasource/food_instruction_datasource_impl.dart';
import 'package:way2fitlife/features/food_instructions/data/repository/food_instruction_repository_impl.dart';
import 'package:way2fitlife/features/food_instructions/domain/repository/food_instruction_repository.dart';
import 'package:way2fitlife/features/food_instructions/domain/usecase/food_instruction_usecase.dart';
import 'package:way2fitlife/features/food_instructions/presentation/bloc/bloc.dart';
import 'package:way2fitlife/features/forget_password/data/datasourse/forgot_password_data_resourse.dart';
import 'package:way2fitlife/features/forget_password/data/datasourse/forgot_password_data_resourse_iml.dart';
import 'package:way2fitlife/features/forget_password/data/repository/forgot_password_repository_iml.dart';
import 'package:way2fitlife/features/forget_password/domain/repository/forgot_password_repository.dart';
import 'package:way2fitlife/features/forget_password/domain/usecase/forgot_password_use_case.dart';
import 'package:way2fitlife/features/forget_password/presentation/bloc/forgot_password_bloc.dart';
import 'package:way2fitlife/features/forum/data/dataresourse/forum_data_resourse.dart';
import 'package:way2fitlife/features/forum/data/dataresourse/forum_data_resourse_iml.dart';
import 'package:way2fitlife/features/forum/data/repository/forum_repository_iml.dart';
import 'package:way2fitlife/features/forum/domain/repository/forum_repository.dart';
import 'package:way2fitlife/features/forum/domain/usecase/forum_use_case.dart';
import 'package:way2fitlife/features/forum/presentation/bloc/forum_bloc.dart';
import 'package:way2fitlife/features/home/data/datasource/home_data_source.dart';
import 'package:way2fitlife/features/home/data/datasource/home_data_source_impl.dart';
import 'package:way2fitlife/features/home/data/repository/home_repository_impl.dart';
import 'package:way2fitlife/features/home/domain/repository/home_repository.dart';
import 'package:way2fitlife/features/home/domain/usecases/home_usecase.dart';
import 'package:way2fitlife/features/home/presentation/bloc/bloc.dart';
import 'package:way2fitlife/features/login/data/datasource/login_datasource.dart';
import 'package:way2fitlife/features/login/data/datasource/login_datasource_impl.dart';
import 'package:way2fitlife/features/login/data/repository/login_repository_impl.dart';
import 'package:way2fitlife/features/login/domain/repository/login_repository.dart';
import 'package:way2fitlife/features/login/domain/usecase/login_usecase.dart';
import 'package:way2fitlife/features/login/presentation/bloc/bloc.dart';
import 'package:way2fitlife/features/photo_gallery/data/dataSource/photo_gallery_datasource.dart';
import 'package:way2fitlife/features/photo_gallery/data/dataSource/photo_gallery_datasource_impl.dart';
import 'package:way2fitlife/features/photo_gallery/data/repository/photo_gallery_repository_impl.dart';
import 'package:way2fitlife/features/photo_gallery/domain/repository/photo_gallery_repository.dart';
import 'package:way2fitlife/features/photo_gallery/domain/usecase/photo_gallery_usecase.dart';
import 'package:way2fitlife/features/photo_gallery/presentation/bloc/bloc.dart';
import 'package:way2fitlife/features/register_page/data/datasource/register_data_source.dart';
import 'package:way2fitlife/features/register_page/data/datasource/register_data_source_iml.dart';
import 'package:way2fitlife/features/register_page/data/repository/register_repository_iml.dart';
import 'package:way2fitlife/features/register_page/domain/repository/register_repository.dart';
import 'package:way2fitlife/features/register_page/domain/usecase/register_use_case.dart';
import 'package:way2fitlife/features/register_page/presentation/bloc/bloc.dart';
import 'package:way2fitlife/features/update_user_data/data/dataresourse/update_user_data_resourse.dart';
import 'package:way2fitlife/features/update_user_data/data/dataresourse/update_user_data_resourse_iml.dart';
import 'package:way2fitlife/features/update_user_data/data/repository/update_user_repository_iml.dart';
import 'package:way2fitlife/features/update_user_data/domain/repository/update_user_repository.dart';
import 'package:way2fitlife/features/update_user_data/domain/usecase/update_user_use_case.dart';
import 'package:way2fitlife/features/update_user_data/presentation/bloc/change_passowrd_bloc/bloc.dart';
import 'package:way2fitlife/features/update_user_data/presentation/bloc/update_user_bloc/bloc.dart';
import 'package:way2fitlife/features/weight_sheet/data/datasource/weight_sheet_datasource.dart';
import 'package:way2fitlife/features/weight_sheet/data/datasource/weight_sheet_datasource_impl.dart';
import 'package:way2fitlife/features/weight_sheet/data/repository/weight_sheet_repository_impl.dart';
import 'package:way2fitlife/features/weight_sheet/domain/repository/weight_sheet_repository.dart';
import 'package:way2fitlife/features/weight_sheet/domain/usecase/weight_sheet_usecase.dart';
import 'package:way2fitlife/features/weight_sheet/presentation/bloc/bloc.dart';

final getIt = GetIt.instance;

Future<void> initGetServiceLocator() async {
  ///DASHBOARD PAGE
  //Bloc
  getIt.registerFactory(() => DashboardBloc(dashboardAnimateUseCase: getIt()));
  //Use case
  getIt.registerFactory(() => DashboardAnimateUseCase(repository: getIt()));
  //DataSource
  getIt.registerLazySingleton<DashboardSource>(() => DashboardSourceImpl());
  //Repository
  getIt.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(dashboardSource: getIt()),
  );

  ///DRAWER PAGE
  //Bloc
  getIt.registerFactory(() => DrawerBloc(drawerUseCase: getIt()));
  //Use Case
  getIt.registerFactory(() => DrawerUseCase(repository: getIt()));
  //DataSource
  getIt.registerLazySingleton<DrawerDataSource>(() => DrawerDataSouceImpl());
  //Repository
  getIt.registerLazySingleton<DrawerRepository>(
      () => DrawerRepositoryImpl(drawerDataSource: getIt()));

  ///HOME PAGE
  //Bloc
  getIt.registerFactory(() => HomeBloc(homeUseCase: getIt()));
  //Use case
  getIt.registerFactory(() => HomeUseCase(repository: getIt()));
  //DataSource
  getIt.registerLazySingleton<HomeDataSource>(() => HomeDataSourceImpl());
  //Repository
  getIt.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(homeDataSource: getIt()));

  ///LOGIN PAGE
  //Bloc
  getIt.registerFactory(() =>
      LogInBloc(logInButtonStatusUseCase: getIt(), logInUseCase: getIt()));
  //Use case
  getIt.registerFactory(
      () => LogInButtonStatusUseCase(logInRepository: getIt()));
  getIt.registerFactory(() => LogInUseCase(logInRepository: getIt()));
  //DataSource
  getIt.registerLazySingleton<LogInDataSource>(() => LogInDataSourceImpl());
  //Repository
  getIt.registerLazySingleton<LogInRepository>(
      () => LogInRepositoryImpl(logInDataSource: getIt()));

  // ///SIGNUP PAGE
  // //Bloc
  // getIt.registerFactory(() => SignUpBloc(
  //       signUpUseCase: getIt(),
  //       signUpEmailUseCase: getIt(),
  //       signUpPasswordUseCase: getIt(),
  //       signUpButtonStatusUseCase: getIt(),
  //     ));
  // //Use case
  // getIt.registerFactory(() => SignUpUseCase(signUpRepository: getIt()));
  // getIt.registerFactory(() => SignUpEmailUseCase(signUpRepository: getIt()));
  // getIt.registerFactory(() => SignUpPasswordUseCase(signUpRepository: getIt()));
  // getIt.registerFactory(() => SignUpButtonStatusUseCase(signUpRepository: getIt()));
  // //DataSource
  // getIt.registerLazySingleton<SignUpDataSource>(() => SignUpDataSourceImpl());
  // //Repository
  // getIt.registerLazySingleton<SignUpRepository>(
  //     () => SignUpRepositoryImpl(signUpDataSource: getIt()));

  ///REGISTER PAGE
  //Bloc
  getIt.registerFactory(() => RegisterBloc(
        registerSendDataUseCase: getIt(),
      ));
  //Use case
  getIt.registerFactory(
      () => RegisterSendDataUseCase(registerRepository: getIt()));
  //repository
  getIt.registerLazySingleton<RegisterRepository>(
      () => RegisterRepositoryIml(registerDataSource: getIt()));
  //dataSourse
  getIt
      .registerLazySingleton<RegisterDataSource>(() => RegisterDataSourceiml());

  ///UPDATE_USER_DATA
  //Bloc
  getIt.registerFactory(() => UpdateUserBloc(updateUserUseCase: getIt()));
  //Use Case
  getIt.registerFactory(() => UpdateUserUseCase(updateUserRepository: getIt()));
  //repository
  getIt.registerLazySingleton<UpdateUserRepository>(
      () => UpdateUserRepositoryIml(updateUserDataResourse: getIt()));
  //dataSourse
  getIt.registerLazySingleton<UpdateUserDataResourse>(
      () => UpdateUserDataResourseIml());

  ///CHANGE PASSWORD
  //BLOC
  getIt.registerFactory(
      () => ChangePasswordBloc(changePasswordUseCase: getIt()));
  //useCase
  getIt.registerFactory(
      () => ChangePasswordUseCase(updateUserRepository: getIt()));

  ///FORGOT PASSWORD
  //BLOC
  getIt.registerFactory(
      () => ForgotPasswordBloc(forgotPasswordUseCase: getIt()));
  //usecase
  getIt.registerFactory(
      () => ForgotPasswordUseCase(forgotPasswordRepository: getIt()));
  //repository
  getIt.registerLazySingleton<ForgotPasswordRepository>(
      () => ForgotPasswordRepositoryIml(forgotPasswordDataResourse: getIt()));
  //data resourse
  getIt.registerLazySingleton<ForgotPasswordDataResourse>(
      () => ForgotPasswordDataResourseIml());

  ///CURRENT BMR PAGE
  //Bloc
  getIt.registerFactory(() => CurrentBMRBloc(
        calculateBMRUseCase: getIt(),
        calculateCaloriesUseCase: getIt(),
        selectGenderUseCase: getIt(),
        selectActivityUseCase: getIt(),
      ));
  //Use case
  getIt.registerFactory(
      () => CalculateBMRUseCase(currentBMRRepository: getIt()));
  getIt.registerFactory(
      () => CalculateCaloriesUseCase(currentBMRRepository: getIt()));
  getIt.registerFactory(
      () => SelectGenderUseCase(currentBMRRepository: getIt()));
  getIt.registerFactory(
      () => SelectActivityUseCase(currentBMRRepository: getIt()));
  //DataSource
  getIt.registerLazySingleton<CurrentBMRDataSource>(
      () => CurrentBMRDataSourceImpl());
  //Repository
  getIt.registerLazySingleton<CurrentBMRRepository>(
      () => CurrentBMRRepositoryImpl(currentBMRDataSource: getIt()));

  ///WEIGHT SHEET PAGE
  //Bloc
  getIt.registerFactory(() => WeightSheetBloc(
        weightSheetUseCase: getIt(),
        weightUseCase: getIt(),
        dateUseCase: getIt(),
        setWeightSheetUseCase: getIt(),
      ));
  //Use Case
  getIt.registerFactory(
      () => WeightSheetUseCase(weightSheetRepository: getIt()));
  getIt.registerFactory(
      () => SetWeightSheetUseCase(weightSheetRepository: getIt()));
  getIt.registerFactory(() => WeightUseCase(weightSheetRepository: getIt()));
  getIt.registerFactory(() => DateUseCase(weightSheetRepository: getIt()));
  //DataSource
  getIt.registerLazySingleton<WeightSheetDataSource>(
      () => WeightSheetDataSourceImpl());
  //Repository
  getIt.registerLazySingleton<WeightSheetRepository>(
      () => WeightSheetRepositoryImpl(weightSheetDataSource: getIt()));

  ///FOOD DIRECTORY PAGE
  //Bloc
  getIt.registerFactory(() => FoodDirectoryBloc(foodDirectoryUseCase: getIt()));
  //Use case
  getIt.registerFactory(
      () => FoodDirectoryUseCase(foodDirectoryRepository: getIt()));
  //DataSource
  getIt.registerLazySingleton<FoodDirectoryDataSource>(
      () => FoodDirectoryDataSourceImpl());
  //Repository
  getIt.registerLazySingleton<FoodDirectoryRepository>(
      () => FoodDirectoryRepositoryImpl(foodDirectoryDataSource: getIt()));

  ///RICH FOOD PAGE
  //Bloc
  getIt.registerFactory(() => RichFoodBloc(
        richFoodUseCase: getIt(),
        richFoodDetailUseCase: getIt(),
      ));
  //Use case
  getIt.registerFactory(() => RichFoodUseCase(richFoodRepository: getIt()));
  getIt.registerFactory(
      () => RichFoodDetailUseCase(richFoodRepository: getIt()));
  //DataSource
  getIt.registerLazySingleton<RichFoodDataSource>(
      () => RichFoodDataSourceImpl());
  //Repository
  getIt.registerLazySingleton<RichFoodRepository>(
      () => RichFoodRepositoryImpl(richFoodDataSource: getIt()));

  ///FORUM
  //bloc
  getIt.registerFactory(
      () => ForumBloc(forumfetchUseCase: getIt(), addForumUseCase: getIt()));
  //use case
  getIt.registerFactory(() => ForumfetchUseCase(forumRepository: getIt()));
  getIt.registerFactory(() => AddForumUseCase(forumRepository: getIt()));
  //repository
  getIt.registerLazySingleton<ForumRepository>(
      () => ForumRepositoryIml(forumDataResourse: getIt()));
  //data resourse
  getIt.registerLazySingleton<ForumDataResourse>(() => ForumDataResouseIml());

  ///COMMENT
  //bloc
  getIt.registerFactory(() => CommentBloc(forumDetailsUseCase: getIt()));
  getIt.registerFactory(() => AddCommentBloc(addCommentUseCase: getIt()));
  //use case
  getIt.registerFactory(() => ForumDetailsUseCase(commentRepository: getIt()));
  getIt.registerFactory(() => AddCommnetUseCase(commentRepository: getIt()));
  //repository
  getIt.registerLazySingleton<CommentRepository>(
      () => CommentRepositoryIml(commentDataResourse: getIt()));
  //data resourse
  getIt.registerLazySingleton<CommentDataResourse>(
      () => CommentDataResourseIml());

  ///PHOTO GALLERY PAGE
  //Bloc
  getIt.registerFactory(() => PhotoGalleryBloc(
        photoGalleryDataUseCase: getIt(),
        setPhotoGalleryDataUseCase: getIt(),
        weightUseCase: getIt(),
        dateUseCase: getIt(),
        photoUseCase: getIt(),
      ));
  //Use Case
  getIt.registerFactory(
      () => PhotoGalleryDataUseCase(photoGalleryRepository: getIt()));
  getIt.registerFactory(
      () => SetPhotoGalleryDataUseCase(photoGalleryRepository: getIt()));
  getIt.registerFactory(
      () => PhotoGalleryPhotoUseCase(photoGalleryRepository: getIt()));
  getIt.registerFactory(
      () => PhotoGalleryWeightUseCase(photoGalleryRepository: getIt()));
  getIt.registerFactory(
      () => PhotoGalleryDateUseCase(photoGalleryRepository: getIt()));
  //DataSource
  getIt.registerLazySingleton<PhotoGalleryDataSource>(
      () => PhotoGalleryDataSourceImpl());
  //Repository
  getIt.registerLazySingleton<PhotoGalleryRepository>(
      () => PhotoGalleryRepositoryImpl(photoGalleryDataSource: getIt()));

  ///COMPARE PAGE
  //Bloc
  getIt.registerFactory(() => CompareBloc(
        getCompareDataUseCase: getIt(),
        setCompareDataUseCase: getIt(),
        weightUseCase: getIt(),
        dateUseCase: getIt(),
        photoUseCase: getIt(),
      ));
  //Use Case
  getIt
      .registerFactory(() => GetCompareDataUseCase(compareRepository: getIt()));
  getIt
      .registerFactory(() => SetCompareDataUseCase(compareRepository: getIt()));
  getIt.registerFactory(() => ComparePhotoUseCase(compareRepository: getIt()));
  getIt.registerFactory(() => CompareWeightUseCase(compareRepository: getIt()));
  getIt.registerFactory(() => CompareDateUseCase(compareRepository: getIt()));
  //DataSource
  getIt.registerLazySingleton<CompareDataSource>(() => CompareDataSourceImpl());
  //Repository
  getIt.registerLazySingleton<CompareRepository>(
      () => CompareRepositoryImpl(compareDataSource: getIt()));

  ///FOOD INSTRUCTION PAGE
  //Bloc
  getIt.registerFactory(
      () => FoodInstructionBloc(foodInstructionUseCase: getIt()));
  //Use Case
  getIt.registerFactory(
      () => FoodInstructionUseCase(foodInstructionRepository: getIt()));
  //DataSource
  getIt.registerLazySingleton<FoodInstructionDataSource>(
      () => FoodInstructionDataSourceImpl());
  //Repository
  getIt.registerLazySingleton<FoodInstructionRepository>(
      () => FoodInstructionRepositoryImpl(foodInstructionDataSource: getIt()));

  ///CHART PAGE
  //Bloc
  getIt.registerFactory(() => ChartBloc(chartDataUseCase: getIt()));
  //Use Case
  getIt.registerFactory(() => ChartDataUseCase(chartRepository: getIt()));
  //DataSource
  getIt.registerLazySingleton<ChartDataSource>(() => ChartDataSourceImpl());
  //Repository
  getIt.registerLazySingleton<ChartRepository>(
      () => ChartRepositoryImpl(chartDataSource: getIt()));

  ///FEEDBACK PAGE
  //Bloc
  getIt.registerFactory(() => FeedbackBloc(
      feedbackDataUseCase: getIt(), feedbackButtonStatusUseCase: getIt()));
  //Use Case
  getIt.registerFactory(() => FeedbackDataUseCase(feedbackRepository: getIt()));
  getIt.registerFactory(
      () => FeedbackButtonStatusUseCase(feedbackRepository: getIt()));
  //DataSource
  getIt.registerLazySingleton<FeedbackDataSource>(
      () => FeedbackDataSourceImpl());
  //Repository
  getIt.registerLazySingleton<FeedbackRepository>(
      () => FeedbackRepositoryImpl(feedbackDataSource: getIt()));

  ///CURRENT BMI PAGE
  //Bloc
  getIt.registerFactory(() => CurrentBMIBloc(useCase: getIt()));
  //Use Case
  getIt.registerFactory(() => CalculateBMIUseCase());
}
