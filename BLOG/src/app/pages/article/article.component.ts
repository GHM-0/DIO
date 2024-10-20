import { Component,OnInit,Input } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';

import {dataMock} from '../../../data/dataMock';

@Component({
  selector: 'app-article',
  templateUrl: './article.component.html',
  styleUrls: ['./article.component.css']
})
export class ArticleComponent implements OnInit{


@Input() date:string="0000-00-01";
@Input() id:string|null="0";
@Input() author:string=`@Author`;
@Input() photoCover:string=`../../../assets/img_placeholder.png`;
@Input() photoInfo:string='random pics of Web';
@Input() title: string=`ARTICLE TITLE`;
@Input() description: string=`Article DESCRIPTION`;
@Input() content: string=`Lorem ipsum dolor sit amet, consectetur adipiscing elit. In in eros quis odio feugiat feugiat.
Vivamus efficitur orci eget sem tristique varius. Sed ultrices eu lacus et luctus. Aliquam enim eros, sagittis a maximus vitae,
ullamcorper quis ipsum. Duis congue, urna viverra fermentum scelerisque, tellus nisi vestibulum tellus, quis ullamcorper
nibh eros quis ipsum. Nullam ornare ac leo a varius. Donec blandit dapibus ligula ut porta. Nunc pharetra massa tellus,
feugiat condimentum enim lobortis eu. Aenean felis augue, mattis at venenatis sed, accumsan ut ante.
Nullam id imperdiet lectus, eget fringilla dui. Aliquam erat volutpat. Ut felis nisl, tempus et nisi eget, tristique
congue purus. In massa magna, aliquam id dictum non, cursus non lorem. Vestibulum ultrices orci et nisl gravida sollicitudin. Quisque laoreet nec odio et dictum. Cras convallis turpis ut elit vehicula, laoreet mollis diam vulputate. Praesent non quam scelerisque, dignissim tellus non, imperdiet mauris.
Nunc ut facilisis elit. Mauris ut nulla et leo sagittis molestie fringilla a leo. Pellentesque sapien ex, euismod eu sem
eu, lobortis tempus libero. Vivamus sed lectus accumsan, pharetra felis quis, condimentum turpis. Suspendisse fermentum a leo maximus lobortis. Phasellus iaculis dui id lorem ultricies, non tempor libero luctus. Mauris ut cursus sem. Aliquam convallis eleifend quam ut ornare. Donec ex lorem, vehicula id suscipit eget, commodo eu diam. Aliquam bibendum eleifend purus, id blandit erat. Praesent iaculis sodales nisi sed tempor. Duis semper augue sit amet dolor tristique, id blandit nunc malesuada. Maecenas in mollis arcu. Nunc pharetra dolor ac nulla hendrerit vulputate.
Sed semper iaculis quam. Sed lacinia sapien nec purus aliquet egestas eget vitae nisi. Phasellus tempor mattis maximus.
 Donec in mi et lorem rhoncus feugiat eget in erat. Donec dignissim malesuada feugiat. Aenean aliquam justo lobortis enim euismod
 aliquet. In elementum diam blandit, hendrerit dui id, mattis eros. Nam tempus felis a maximus ultricies. Praesent pulvinar
 magna eu enim sodales blandit. Vestibulum semper felis placerat malesuada convallis. Quisque sit amet aliquet sem, tristique
 pellentesque tortor. Suspendisse sollicitudin eu mauris ac pretium. Integer feugiat ultricies nibh, eget faucibus ex gravida
 sit amet. Nunc tempus, nisl nec accumsan pharetra, libero eros rhoncus sapien, a molestie felis sapien id justo. Duis nisi
 risus, mattis vitae efficitur eget, suscipit et nulla.
Integer erat sapien, convallis quis lacus nec, convallis condimentum tellus. Vivamus id efficitur lectus, ac accumsan ligula.
Nullam nulla libero, lacinia vel sollicitudin in, tincidunt id mi. Proin luctus dignissim gravida. Mauris at nulla sed enim
ultricies rhoncus. Maecenas tincidunt tortor vulputate ultricies ultricies. Pellentesque pellentesque pellentesque consequat.
Phasellus lobortis magna ut nibh hendrerit aliquam. Duis in scelerisque metus. Duis vehicula justo est, at ultrices sem egestas eget.
Aliquam accumsan varius magna, ac molestie quam dictum eu. Mauris efficitur, ligula vitae aliquet blandit, enim ante volutpat
tellus, in gravida enim eros nec tellus. In hendrerit velit sed neque viverra, at scelerisque diam finibus. Nulla aliquam semper
interdum. Sed varius pulvinar eros, rutrum fringilla dui pretium eget. Nullam et dignissim lectus, sed rhoncus ipsum. Aenean
 volutpat sem et accumsan gravida. Donec sed mollis eros, a accumsan turpis. Morbi eleifend, arcu at pharetra congue, elit leo
 scelerisque justo, ac pulvinar est ipsum sit amet justo. Duis sed lacus orci. Phasellus sit amet tellus dapibus, consectetur
ligula eu, auctor nulla. Cras sed lectus porta, ullamcorper orci vel, rhoncus erat. Proin interdum eu nisi in sagittis.
Curabitur auctor nisi accumsan ex condimentum, vel egestas risus sagittis. Ut feugiat nulla ante, sit amet mollis magna
semper non. Vivamus porta diam ut sapien maximus, posuere iaculis massa mollis.
Nunc efficitur ac massa quis blandit. Donec varius volutpat molestie. Morbi a accumsan odio. Maecenas rutrum libero id
bibendum rhoncus. Sed dictum dictum diam quis pretium. Morbi accumsan orci ornare, eleifend tortor ac, consequat nibh.
Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.`;

constructor(private nav:Router, private  route:ActivatedRoute){
/* 			this.route.firstChild?.params.subscribe(param=>console.log("Parameters in URL:"+param));
			this.route.firstChild?.queryParams.subscribe(args => console.log("Variaveis passadas na url:"+args)); */
}

ngOnInit(){
	this.route.paramMap.subscribe(value => this.id=value.get("id"));
	this.setValuesToArticle(this.id);

	window.scrollTo(0, 0);

	//Redirecinoa para home apois 5 segundos
/* 	setInterval(()=>{
		this.nav.navigate(['/']);
	},5000) */
}

setValuesToArticle(id:string|null){
	const result=dataMock.filter(
		article => article.id.toString()==id)[0];

		if(result!=null){
			this.author=result.author;
			this.title=result.title;
			this.photoCover=result.photoCover;
			//this.photoInfo=result.photoInfo;
			this.description=result.description;
			this.content=result.content;
			//this.date=result.date;
		}
}

}
