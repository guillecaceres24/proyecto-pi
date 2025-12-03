import { Routes } from '@angular/router';
import { LoginComponent } from './pages/login/login.component';
import { HomeComponent } from './pages/home/home.component';
import { StudentDetailComponent } from './pages/student-detail/student-detail.component';

export const routes: Routes = [
  // 👉 Ahora la ruta por defecto redirige a login
  { path: '', redirectTo: 'login', pathMatch: 'full' },

  { path: 'login', component: LoginComponent },
  { path: 'home', component: HomeComponent },
  { path: 'student/:id', component: StudentDetailComponent },

  // 👉 Si la ruta no existe también te manda al login
  { path: '**', redirectTo: 'login' }
];
