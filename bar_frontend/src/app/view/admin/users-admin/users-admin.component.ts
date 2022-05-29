import {Component, OnInit} from '@angular/core';
import {UserServiceImpl} from "../../../service/impl/UserServiceImpl";
import {User} from "../../../model/User";
import {Sort} from "@angular/material/sort";
import {EditUserDialogComponent} from "../../dialog/edit-user-dialog/edit-user-dialog.component";
import { MatDialog } from '@angular/material/dialog';
import {DialogAction, DialogResult} from "../../dialog/DialogResult";

@Component({
  selector: 'app-users-admin',
  templateUrl: './users-admin.component.html',
  styleUrls: ['./users-admin.component.css']
})
export class UsersAdminComponent implements OnInit {

  users: User[];
  sortedData: User[];


  constructor(
    private dialog: MatDialog,
    private userService: UserServiceImpl) {
    this.userService.findAll().subscribe(users => {
      this.sortedData = users;
      this.users = users;
    });
  }

  ngOnInit(): void {
  }

  updateUser(user: User){
    this.userService.update(user).subscribe();
  }

  toggleEnabled(user: User) {

    if (user.enabled) {
      user.enabled = false;
    } else {
      user.enabled = true;
    }

    this.updateUser(user);
  }

  sortData(sort: Sort) {
    const data = this.users.slice();
    if (!sort.active || sort.direction === '') {
      this.sortedData = data;
      return;
    }

    this.sortedData = data.sort((a, b) => {
      const isAsc = sort.direction === 'asc';
      switch (sort.active) {
        case 'userId':
          return compare(a.userId, b.userId, isAsc);
        case 'username':
          return compare(a.username, b.username, isAsc);
        case 'name':
          return compare(a.name, b.name, isAsc);
        case 'surname':
          return compare(a.surname, b.surname, isAsc);
        case 'role':
          return compare(a.role, b.role, isAsc);
        case 'enabled':
          return compare(a.enabled, b.enabled, isAsc);
        case 'regDate':
          return compare(a.regDate, b.regDate, isAsc);
        default:
          return 0;
      }
    });
  }

  openEditDialog(user: User): void {


    const dialogRef = this.dialog.open(EditUserDialogComponent, {
      data: [user],
      autoFocus: false
    });

    dialogRef.afterClosed().subscribe(result => {

      if (!(result)) {
        return;
      }

      if (result.action === DialogAction.SAVE) {
        this.updateUser(user);
        return;
      }
    });
  }
}

function compare(a: number | string | boolean | Date,
                 b: number | string | boolean | Date, isAsc: boolean) {
  return (a < b ? -1 : 1) * (isAsc ? 1 : -1);
}
