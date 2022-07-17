class HomeSliderModel{
  String name,imageUrl,offerId;
  HomeSliderModel(this.name,this.imageUrl,this.offerId);



  HomeSliderModel.fromJson(Map<dynamic, dynamic> map){
    if(map==null){
      return;
    }
    name=map['name'];
    imageUrl=map['imageUrl'];
    offerId=map['offerId'];
  }
}

