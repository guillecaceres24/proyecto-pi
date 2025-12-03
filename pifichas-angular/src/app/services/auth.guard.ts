// services/auth.guard.ts

import { Injectable } from '@angular/core';
import { CanActivate, Router, UrlTree } from '@angular/router';
import { AuthService } from './auth.service'; // Ruta relativa correcta: ./auth.service

@Injectable({
  providedIn: 'root'
})
export class AuthGuard implements CanActivate {
  
  constructor(
    private authService: AuthService, 
    private router: Router
  ) {}

  canActivate(): boolean | UrlTree {
    // 1. Verifica si el usuario está logueado a través del servicio
    if (this.authService.isAuthenticated()) {
      // El usuario tiene una sesión activa, permite el acceso a la ruta (e.g., /home)
      return true;
    } 
    
    // 2. Si no hay sesión, bloquea la navegación y redirige al login
    console.log('Navegación bloqueada: Sesión no encontrada.');
    return this.router.createUrlTree(['/login']); 
  }
}