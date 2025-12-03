import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { map, catchError } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private baseUrl = 'http://localhost:3000';

  constructor(private http: HttpClient) {}

  login(correo: string, contrasenia: string): Observable<any> {
    return this.http.post<any>(`${this.baseUrl}/login`, { correo, contrasenia }).pipe(
      map(res => {
        if (res && res.profesor) {
          localStorage.setItem('user', JSON.stringify(res.profesor));
          return res.profesor;
        } else {
          throw new Error('Usuario o contraseña incorrectos');
        }
      }),
      catchError(err => throwError(() => err))
    );
  }

  logout(): void {
    localStorage.removeItem('user');
  }

  getCurrentUser(): any {
    const user = localStorage.getItem('user');
    return user ? JSON.parse(user) : null;
  }

  isAuthenticated(): boolean {
    return !!this.getCurrentUser();
  }
}
