import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { HomeComponent } from './pages/home/home.component';
import { ArticleComponent } from './pages/article/article.component';

const routes: Routes = [
{
	path:'',
	component:HomeComponent,
	pathMatch:'full'
}
// ,{                  //Não carrega o dataMock
// 	path:'article',component:ArticleComponent,
// 	children:[{path:':id',component:ArticleComponent}]   //Sub rota
// }
,{
	path:'article/:id',component:ArticleComponent
}
,{
	path:'**',
	redirectTo:''
}];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
