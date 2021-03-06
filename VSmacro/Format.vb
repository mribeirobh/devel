Imports System
Imports EnvDTE
Imports EnvDTE80
Imports EnvDTE90
Imports EnvDTE90a
Imports EnvDTE100
Imports System.Diagnostics
Imports System.Collections.Generic

Public Module Format


    Dim allowed As List(Of String)
    Dim message As String
    Dim pos As Integer
    Dim status As String

    Public Sub Solution_Docs_Format()

        allowed = New List(Of String)
        allowed.Add(".master")
        allowed.Add(".aspx")
        allowed.Add(".ascx")
        allowed.Add(".asmx")
        allowed.Add(".cs")
        allowed.Add(".vb")
        allowed.Add(".config")
        allowed.Add(".css")
        allowed.Add(".htm")
        allowed.Add(".html")
        allowed.Add(".js")

        Dim sol As Solution = DTE.Solution

        ClearOutput()

        DTE.Windows.Item(Constants.vsWindowKindSolutionExplorer).Activate()
        Dim solutionName As String = sol.Properties.Item("Name").Value.ToString()

        Dim startTime As DateTime = Now
        message = String.Format("{0} {1}", "Inicio: ", startTime.ToString("dd/MM/yyyy HH:mm:ss"))
        OutMessage(message)

        DTE.ActiveWindow.Object.GetItem(solutionName).Select(vsUISelectionType.vsUISelectionTypeSelect)

        message = String.Format("{0}", solutionName)
        OutMessage(message)

        For Each item As Project In sol.Projects
            If (item.ProjectItems IsNot Nothing) Then
                message = String.Format("{0}{1}", " ", item.Name)
                OutMessage(message)
                searchFiles(item.ProjectItems, 1)
            Else
                message = String.Format("{0}{1}", " ", item.Name)
                OutMessage(message)
            End If
        Next
        Dim endTime As DateTime = Now
        message = String.Format("{0} {1}", "Fim: ", endTime.ToString("dd/MM/yyyy HH:mm:ss"))
        OutMessage(message)
        message = String.Format("{0} {1}", "Time Transaction: ", endTime.Subtract(startTime).TotalMinutes.ToString("F5"))
        OutMessage(message)
    End Sub

    Sub searchFiles(ByVal items As ProjectItems, ByVal deep As Integer)
        Dim searchDeep As Integer = deep + 1
        Dim deepString As String = New String(" ", searchDeep)

        For Each item As ProjectItem In items
            If (item.SubProject IsNot Nothing) Then
                message = String.Format("{0}{1}", deepString, item.SubProject.Name)
                OutMessage(message)
                searchFiles(item.SubProject.ProjectItems, deep + 1)
            Else
                pos = item.Name.LastIndexOf(".")
                message = String.Format("{0}{1}", deepString, item.Name)
                If (pos > 0) Then
                    Dim fileType As String = item.Name.Substring(pos)
                    If (allowed.Contains(fileType)) Then
                        message += " " + formatItem(item)
                    End If
                End If
                OutMessage(message)
                searchFiles(item.ProjectItems, searchDeep)
            End If
        Next
    End Sub


    Private Sub ClearOutput()
        Dim window As Window = DTE.Windows.Item(EnvDTE.Constants.vsWindowKindOutput)
        Dim outputWindow As OutputWindow = window.Object
        Dim namePane As String = String.Format("{0} {1}", "Project Format", "")
        Dim owp As OutputWindowPane = Nothing
        If (outputWindow.OutputWindowPanes.Count > 0) Then
            For Each lowp As OutputWindowPane In outputWindow.OutputWindowPanes
                If (lowp.Name.Equals(namePane)) Then
                    owp = lowp
                End If
            Next
        End If
        If (owp Is Nothing) Then
            owp = outputWindow.OutputWindowPanes.Add(namePane)
        End If
        owp.Activate()
        owp.Clear()
    End Sub

    Private Sub OutMessage(ByVal message As String)
        Dim window As Window = DTE.Windows.Item(EnvDTE.Constants.vsWindowKindOutput)
        Dim outputWindow As OutputWindow = window.Object
        outputWindow.ActivePane.Activate()
        message = message + vbCrLf
        outputWindow.ActivePane.OutputString(message)
    End Sub

    Function formatItem(ByVal Item As ProjectItem)       
        status = "NO PROCESS"
        Dim window As EnvDTE.Window
        Try
            Try
                window = Item.Open(ViewKind:=Constants.vsViewKindCode)
            Catch
                Try
                    window = Item.Open(ViewKind:=Constants.vsViewKindTextView)
                Catch
                    window = Item.Open(ViewKind:=Constants.vsViewKindAny)
                End Try
            End Try
            window.Activate()
            DTE.ExecuteCommand("Edit.FormatDocument", "")
            DTE.ExecuteCommand("EditorContextMenus.CodeWindow.OrganizeUsings.RemoveAndSort", "")
            status = "OK"
        Catch ex As Exception
            status = ex.Message
        End Try
        Try
            window.Document.Save()
            window.Close()
        Catch
        End Try
        Return status
    End Function

End Module
