Clear-Host;

#https://stackoverflow.com/a/5466355/18457167
Set-Location $PSScriptRoot;

$usersFilePath = "./nom.csv";
$groupName = "Entreprise";

function CreateUser($name) {
  $user = Get-LocalUser | Where-Object Name -eq $name;

  if (!$user) {
    New-LocalUser -Name $name -FullName $name -Description "Compte pour $name";
    Write-Host "Cr�ation de l'utilisateur $name avec succ�s!";
    AssignGroup "$name" "$groupName";
  } else {
    Write-Host "Utilisateur $name d�ja �xistant!";
  }
}

function CreateGroup($name) {
  $group = Get-LocalGroup | Where-Object Name -eq $name;

  if (!$group) {
    $group = New-LocalGroup -Name $name -Description "Groupe pour le travail de JPD";
    Write-Host "Cr�ation du groupe $name avec succ�s!";
  } else {
    Write-Host "Groupe $name d�ja �xistant!";
  }
}

function AssignGroup($user, $group) {
 $members = Get-LocalGroupMember -Group $group;

 if ($members -clike "*$user") {
   Write-Host "$user appartient d�ja au groupe $group";
 } else {
   Write-Host "Ajout de l'utilisateur $user dans $group";
   Add-LocalGroupMember -Group $group -Member $user, "MicrosoftAccount\$user@csfoy.ca";
 }
}

function init() {
  $file = Get-Item -Path $usersFilePath -ErrorAction Ignore;

  CreateGroup($groupName);

  if ($file) {
    $content = Get-Content $usersFilePath;
    foreach ($line in $content) {
       CreateUser($line);
    }
  } else {
    Write-Host "Le fichier $usersFilePath est introuvable!";
  }
}

#init;


AssignGroup "natha" "Entreprise";