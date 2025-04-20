import 'dart:math';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:monumental_habits/util/helper.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  final Graph graph = Graph();
  final List<Node> nodes = [];
  int _iterations = 300;
  TextEditingController _textController = TextEditingController();
  Node? _selectedNode;

  Map<int, String> nodeLabels = {};
  Map<int, String> nodeClouds = {};

  final List<String> cloudAssets = [
    'assets/images/Cloud.svg',
    // Add more cloud SVGs if desired
  ];

  final Random random = Random();

  String _getRandomCloudAsset() {
    return cloudAssets[random.nextInt(cloudAssets.length)];
  }

  void _onNodeTap(Node parentNode) {
    setState(() {
      _selectedNode = parentNode;
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Label for New Node'),
          content: TextField(
            controller: _textController,
            decoration: InputDecoration(hintText: 'Enter label'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_textController.text.isNotEmpty) {
                  _addChildToNode(parentNode, _textController.text);
                  _textController.clear();
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add Node'),
            ),
            TextButton(
              onPressed: () {
                _textController.clear();
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _addChildToNode(Node parentNode, String label) {
    final newNodeId = nodes.length;
    final newNode = Node.Id(newNodeId);
    nodes.add(newNode);
    graph.addNode(newNode);

    nodeLabels[newNodeId] = label;
    nodeClouds[newNodeId] = _getRandomCloudAsset();

    _addEdge(parentNode, newNode);
    setState(() {});
  }

  void _addEdge(Node source, Node destination) {
    graph.addEdge(
      source,
      destination,
      paint: Paint()
        ..color = Color(darkOrange)
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke,
    );
  }

  void _showDeleteConfirmationDialog(Node node) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Node'),
        content: Text('Are you sure you want to delete this node?'),
        actions: [
          TextButton(
            onPressed: () {
              _deleteNode(node);
              Navigator.of(context).pop();
            },
            child: Text('Delete'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _deleteNode(Node node) {
    final nodeId = node.key!.value as int;
    graph.removeNode(node);
    nodes.remove(node);
    nodeLabels.remove(nodeId);
    nodeClouds.remove(nodeId);
    setState(() {});
  }

  void _addInitialNode() {
    if (nodes.isEmpty) {
      final newNode = Node.Id(0);
      nodes.add(newNode);
      graph.addNode(newNode);
      nodeClouds[0] = _getRandomCloudAsset();
      nodeLabels[0] = "Goal";
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          IconButton(onPressed: _addInitialNode, icon: Icon(Icons.add)),
          Expanded(
            flex: 3,
            child: Card(
              color: Colors.white,
              child: InteractiveViewer(
                minScale: 0.1,
                maxScale: 5,
                boundaryMargin: const EdgeInsets.all(100),
                child: GraphView(
                  graph: graph,
                  algorithm:
                      FruchtermanReingoldAlgorithm(iterations: _iterations),
                  builder: (node) {
                    final idx = node.key!.value as int;
                    final label = nodeLabels[idx] ?? 'Node';
                    final cloudPath = nodeClouds[idx] ?? cloudAssets[0];

                    return GestureDetector(
                      onTap: () => _onNodeTap(node),
                      onLongPress: () => _showDeleteConfirmationDialog(node),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SvgPicture.asset(
                            cloudPath,
                            width: 100,
                            height: 70,
                            fit: BoxFit.contain,
                            colorFilter: const ColorFilter.mode(
                              Color(0xFFFFDFC1),
                              BlendMode.srcIn,
                            ),
                          ),
                          Text(
                            label,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(flex: 1, child: SizedBox())
        ],
      ),
    );
  }
}
