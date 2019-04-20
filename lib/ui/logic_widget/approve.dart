import 'package:F4Lab/user_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:F4Lab/model/approvals.dart';
import 'package:F4Lab/api.dart';

class MrApprove extends StatefulWidget {
  final int projectId;
  final int mrIID;
  final bool showActions;

  MrApprove(this.projectId, this.mrIID, {this.showActions = false});

  @override
  State<StatefulWidget> createState() => _MrApproveState();
}

class _MrApproveState extends State<MrApprove>
    with AutomaticKeepAliveClientMixin {
  Approvals approval;
  bool isApproving = false;

  void _loadApprove() async {
    final apiResp =
        await ApiService.mrApproveData(widget.projectId, widget.mrIID);
    if (mounted) {
      setState(() {
        approval = apiResp.data;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadApprove();
  }

  @override
  Widget build(BuildContext context) {
    if (approval == null || isApproving) {
      return LinearProgressIndicator();
    }
    return _buildItem(approval);
  }

  Widget _buildItem(Approvals ap) {
    int requireApproves = ap.approvalsRequired ?? 0;
    int hadApproval = ap.approvedBy != null ? ap.approvedBy.length : 0;
    bool allApproval = requireApproves == hadApproval;
    bool iHadApproval = ap.approvedBy != null
        ? ap.approvedBy.any((item) => item.user.id == UserHelper.getUser().id)
        : false;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Row(
          children: <Widget>[
            Icon(Icons.sentiment_neutral),
            Expanded(
              child: Text(
                "Approvals: $hadApproval of $requireApproves",
                style:
                    TextStyle(color: allApproval ? Colors.green : Colors.grey),
              ),
            ),
            widget.showActions ? _buildActions(iHadApproval) : IgnorePointer(),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget _buildActions(bool iHadApproval) {
    return OutlineButton(
      onPressed: () => _approveOrUnApprove(!iHadApproval),
      child: Text(iHadApproval ? "UnApprove" : "Approve"),
    );
  }

  void _approveOrUnApprove(bool isApprove) async {
    setState(() {
      isApproving = true;
    });
    final ApiResp<String> apiData =
        await ApiService.approve(widget.projectId, widget.mrIID, isApprove);
    setState(() {
      isApproving = false;
    });
    if (apiData.success) {
      _loadApprove();
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("${apiData.err}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
