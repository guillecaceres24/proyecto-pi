import { Component, OnDestroy, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from '../../services/auth.service';
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnDestroy {
  correo = '';
  contrasenia = '';
  isLoading = false;
  errorMessage = '';

  private loginSubscription: Subscription | undefined;

  constructor(
    private authService: AuthService,
    private router: Router,
    private cd: ChangeDetectorRef
  ) {}

  ngOnDestroy(): void {
    if (this.loginSubscription) {
      this.loginSubscription.unsubscribe();
    }
  }

  login(): void {
    this.isLoading = true;
    this.errorMessage = '';

    this.loginSubscription = this.authService.login(this.correo, this.contrasenia).subscribe({
      next: (profesor) => {
        // ✅ Actualiza la UI inmediatamente
        this.isLoading = false;
        this.cd.detectChanges();

        if (profesor) {
          this.router.navigate(['/home']);
        } else {
          this.errorMessage = 'Usuario o contraseña incorrectos.';
        }
      },
      error: (err: any) => {
        // ✅ Actualiza la UI inmediatamente
        this.isLoading = false;
        this.cd.detectChanges();

        if (err.status === 401) {
          this.errorMessage = 'Usuario o contraseña incorrectos.';
        } else {
          this.errorMessage = 'Error al conectar con el servidor. Inténtalo de nuevo.';
        }

        console.error('Error de login:', err);
      }
    });
  }
}
