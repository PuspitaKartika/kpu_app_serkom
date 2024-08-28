import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpu_app_serkom/bloc/get_user/get_user_cubit.dart';
import 'package:kpu_app_serkom/view/detail_data_screen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  void initState(){
    super.initState();
    context.read<GetUserCubit>().getUser();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("List Data"),),
      body: BlocBuilder<GetUserCubit, GetUserState>(
        builder: (context, state) {
          if(state is GetUserLoading){
            return const Center(child: CircularProgressIndicator(),);
          } else if (state is GetUserError){
            return const Center(child: Text("Maaf sedang ada kendala"),);
          } else if (state is GetUserSuccess){
            return  ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (context, index){
              return ListTile(
                onTap: () { 
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> DetailDataScreen(voter: state.data[index],)));
                },
                leading: CircleAvatar(child: Text(state.data[index].name[0]),),
                title: Text(state.data[index].name),
                subtitle: Text(state.data[index].nik.toString()),
              );
            });
      
          } return const SizedBox();
        }),
    );
    
  }
}